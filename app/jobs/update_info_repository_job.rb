# frozen_string_literal: true

class UpdateInfoRepositoryJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    CheckRepositoryJob.perform_later job.arguments.first
  end

  def perform(check)
    repository = check.repository
    user = repository.user
    client = Octokit::Client.new access_token: user.token

    response = client.repo(repository.full_name)

    repository_default_branch = client.branch(response.id, response.default_branch)

    last_commit_id = repository_default_branch.commit.sha[0, 7]

    response[:last_commit_id] = last_commit_id

    repository.update! serialize_repository_response(response)
  end

  private

  def serialize_repository_response(data)
    {
      name: data.name,
      owner_login: data.owner.login,
      full_name: data.full_name,
      url: data.url,
      html_url: data.html_url,
      language: data.language.downcase!,
      github_id: data.id,
      pushed_at: data.pushed_at,
      git_url: data.git_url,
      last_commit_id: data.last_commit_id
    }
  end
end
