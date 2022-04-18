# frozen_string_literal: true

class GithubHookCreateJob < ApplicationJob
  queue_as :default

  def perform(repo_id, access_token)
    octokit_client_api = ApplicationContainer[:octokit_client_api]
    client = octokit_client_api.new access_token
    client.create_hook(repo_id) unless client.hook?(repo_id)
  rescue StandardError
    StandardError.new("Error while webhook creating for repository id: #{repo_id}")
  end
end
