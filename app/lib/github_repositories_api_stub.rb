# frozen_string_literal: true

class GithubRepositoriesApiStub
  def self.get(access_token)
    body = File.read(Rails.root.join('test/fixtures/files/github_repos_response.json'))

    response = WebMock.stub_request(:get, 'https://api.github.com/user/repos')
           .with(
             headers: {
               'Accept' => 'application/vnd.github.v3+json',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Authorization' => "token #{access_token}",
               'Content-Type' => 'application/json',
               'User-Agent' => 'Octokit Ruby Gem 4.22.0'
             }
           )
           .to_return(status: 200, body: body, headers: {})

    JSON.parse(response)
  end
end
