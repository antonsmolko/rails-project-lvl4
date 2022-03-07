# frozen_string_literal: true

class GithubHookCreateRunner
  def self.start(github_id, user_token)
    GithubHookCreateJob.perform_later github_id, user_token
  end
end
