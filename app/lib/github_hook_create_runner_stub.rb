# frozen_string_literal: true

class GithubHookCreateRunnerStub
  def self.start(github_id, access_token)
    WebMock.stub_request(:post, "https://api.github.com/repositories/#{github_id}/hooks")
           .with(
             body: {
               name: 'web',
               config: {
                 url: "#{Rails.application.routes.default_url_options}/api/checks"
               },
               events: ['push'],
               active: true
             },
             headers: {
               'Accept' => 'application/vnd.github.v3+json',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Authorization' => "token #{access_token}",
               'Content-Type' => 'application/json',
               'User-Agent' => 'Octokit Ruby Gem 4.22.0'
             }
           )
           .to_return(status: 200, body: '', headers: {})
  end
end
