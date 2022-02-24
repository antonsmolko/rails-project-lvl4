# frozen_string_literal: true

class RepositoryCheckRunner
  def self.start(check)
    RepositoryCloneJob.perform_later check
  end
end
