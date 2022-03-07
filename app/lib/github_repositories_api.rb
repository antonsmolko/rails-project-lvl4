# frozen_string_literal: true

class GithubRepositoriesApi
  def self.get(access_token)
    client = Octokit::Client.new access_token: access_token
    client.repos
  end
end
