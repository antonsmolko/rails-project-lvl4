# frozen_string_literal: true

class RepositoryCheckRunner
  def self.start(repository)
    check = repository.checks.create!
    RepositoryCloneJob.perform_later check
  end
end
