# frozen_string_literal: true

class CheckRepositoryRunner
  def self.start(check)
    CloneRepositoryJob.perform_later check
  end
end
