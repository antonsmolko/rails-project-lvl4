# frozen_string_literal: true

class OctokitClientApi
  include Rails.application.routes.url_helpers

  attr_accessor :client

  def initialize(access_token)
    @client = Octokit::Client.new access_token: access_token
  end

  def repos
    @client.repos
  end

  def repo(repo_id)
    @client.repo repo_id
  end

  def branch(repo_id, default_branch)
    @client.branch repo_id, default_branch
  end

  def create_hook(repo_id)
    @client.create_hook(repo_id, 'web', url: api_checks_url, content_type: 'json')
  end
end
