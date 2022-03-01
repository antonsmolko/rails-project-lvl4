# frozen_string_literal: true

class UpdateInfoRepositoryJob < ApplicationJob
  queue_as :default

  attr_accessor :check_id

  after_perform do |job|
    CloneRepositoryJob.perform_later job.arguments.first
  end

  def perform(check_id, user_id)
    check = Repository::Check.find check_id
    repository = check.repository
    user = User.find user_id
    client = Octokit::Client.new access_token: user.token

    response = client.repo(repository.github_id)

    repository_default_branch = client.branch(response.id, response.default_branch)

    last_commit_id = repository_default_branch.commit.sha[0, 7]

    response[:last_commit_id] = last_commit_id

    repository = user.repositories.where(github_id: repository.github_id).first_or_initialize

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
