# frozen_string_literal: true

class CheckRepositoryRunner
  def self.start(check_id)
    check = Repository::Check.find check_id
    repository = check.repository
    UpdateInfoRepositoryJob.perform_later check.id, repository.user.id
  end
end
