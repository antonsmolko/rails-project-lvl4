# frozen_string_literal: true

require_relative '../services/check_repository_service'

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find(check_id)
    return unless check.created?

    CheckRepositoryService.check(check)
  end
end
