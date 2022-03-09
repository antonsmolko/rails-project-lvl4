# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  attr_accessor :check

  def perform(repository)
    @check = repository.checks.where(aasm_state: 'created').last!
    @check.check!

    check_repository_runner = ApplicationContainer[:check_repository_runner]
    check_data = check_repository_runner.start repository

    data = StdoutSerializer.build check_data, repository.language

    issues_count = data[:issues_count]
    passed = issues_count.zero?

    if @check.update!(
      passed: passed,
      listing: data[:listing],
      issues_count: issues_count
    )
      @check.finish!
    else
      StandardError
    end

    @check.send_failed unless passed
  rescue StandardError => e
    logger.debug "check repository job error: #{e.message}"
    @check.mark_as_failed!
  end
end
