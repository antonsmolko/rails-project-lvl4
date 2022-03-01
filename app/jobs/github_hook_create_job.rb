# frozen_string_literal: true

class GithubHookCreateJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(github_id, access_token)
    client = Octokit::Client.new access_token: access_token
    client.create_hook(github_id, 'web', url: api_checks_url)
  rescue StandardError
    StandardError.new("Error while webhook creating for repository id: #{github_id}")
  end

  class << self
    def default_url_options
      Rails.application.routes.default_url_options
    end
  end
end
