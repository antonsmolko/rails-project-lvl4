# frozen_string_literal: true

require 'rss'

class OctokitClientApiStub
  attr_accessor :access_token

  BASE_URL = 'https://api.github.com'

  def initialize(access_token)
    @access_token = access_token
  end

  def repos
    body = get_fixture_by_name 'github_repos_response.json'
    url = "#{BASE_URL}/user/repos"

    get_response url, body
  end

  def repo(github_id)
    body = get_fixture_by_name 'ruby_repository_response.json'
    url = "#{BASE_URL}/repos/#{github_id}"

    get_response url, body
  end

  def branch(full_name, branch)
    body = get_fixture_by_name 'default_branch_response.json'
    url = "#{BASE_URL}/repos/#{full_name}/branches/#{branch}"

    get_response url, body
  end

  def create_hook(repo_id)
    url = "#{BASE_URL}/repositories/#{repo_id}/hooks"
    body = ['success'].to_json
    config = {
      body: {
        name: 'web',
        config: { url: "#{Rails.application.routes.default_url_options}/api/checks" },
        events: ['push'],
        active: true
      }
    }

    get_response url, body, config
  end

  def hook?(_)
    false
  end

  private

  def get_fixture_by_name(name)
    File.read(Rails.root.join('test/fixtures/files', name))
  end

  def get_response(url, body = '{}', config = {})
    data = WebMock.stub_request(:get, url)
                  .with(
                    headers: {
                      'Authorization' => "token #{@access_token}",
                      'Content-Type' => 'application/json'
                    },
                    **config
                  )
                  .to_return(status: 200, body: body, headers: {})

    JSON.parse data.response.body
  end
end
