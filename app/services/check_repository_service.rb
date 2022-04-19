# frozen_string_literal: true

class CheckRepositoryService
  def self.check(check)
    check.check!

    check_repository_runner = ApplicationContainer[:check_repository_runner]
    repository = check.repository
    check_data = check_repository_runner.start repository

    data = StdoutSerializer.build check_data, repository.language

    issues_count = data[:issues_count]
    passed = issues_count.zero?

    if check.update(
      passed: passed,
      listing: data[:listing],
      issues_count: issues_count
    )
      check.finish!
    else
      raise StandardError, "Check can not be updated: #{check.id}"
    end

    RepositoryCheckMailer.with(check).check_failed.deliver_later unless passed
  rescue StandardError => e
    Rails.logger.error e.message.to_s
    RepositoryCheckMailer.with(check).check_error.deliver_later
    check.mark_as_failed!
  end
end
