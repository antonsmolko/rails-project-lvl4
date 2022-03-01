# frozen_string_literal: true

class CheckRepositoryRunner
  def self.start(check_id)
    UpdateInfoRepositoryJob.perform_later check_id
  end
end
