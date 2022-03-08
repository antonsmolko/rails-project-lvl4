# frozen_string_literal: true

class GithubHookCreateRunner
  def self.start(full_name, user_token)
    GithubHookCreateJob.perform_later full_name, user_token
  end
end
