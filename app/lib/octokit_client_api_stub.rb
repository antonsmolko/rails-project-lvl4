# frozen_string_literal: true

require 'rss'

class OctokitClientApiStub
  attr_accessor :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def repos
    body = File.read(Rails.root.join('test/fixtures/files/github_repos_response.json'))
    url = 'https://api.github.com/user/repos'

    get_response url, body
  end

  def repo(github_id)
    #rubocop: disable all
    p '=' * 90
    p github_id
    p '=' * 90
    #rubocop: enable all
    mapping = {
      404_106_344 => 'ruby',
      1_296_269 => 'javascript'
    }

    language = mapping[github_id]

    body = File.read(Rails.root.join("test/fixtures/files/#{language}_repository_response.json"))
    url = "https://api.github.com/repos/#{github_id}"

    get_response url, body
  end

  def branch(full_name, branch)
    body = File.read(Rails.root.join('test/fixtures/files/default_branch_response.json'))
    url = "https://api.github.com/repos/#{full_name}/branches/#{branch}"

    get_response url, body
  end

  def create_hook(repo_id)
    url = "https://api.github.com/repositories/#{repo_id}/hooks"
    config = {
      body: {
        name: 'web',
        config: { url: "#{Rails.application.routes.default_url_options}/api/checks" },
        events: ['push'],
        active: true
      }
    }

    get_response url, '', config
  end

  private

  def get_response(url, body = {}, config = {})
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
