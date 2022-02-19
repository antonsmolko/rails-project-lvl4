# frozen_string_literal: true

class RepositoryCheckRunner
  def self.start(check, repository_id)
    RepositoryCloneJob.perform_later check, repository_id
  end
end
