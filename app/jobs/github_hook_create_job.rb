class GithubHookCreateJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(token, github_id)
    client = Octokit::Client.new access_token: token
    client.create_hook(github_id, 'web', url: api_checks_url)
  rescue
    StandardError.new("Error while webhook creating for repository id: #{github_id}")
  end
end
