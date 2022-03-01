# frozen_string_literal: true

class CheckRepositoryRunner
  def self.start(check)
    UpdateInfoRepositoryJob.perform_later check
  end
end
