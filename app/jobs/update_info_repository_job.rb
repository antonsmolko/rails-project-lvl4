# frozen_string_literal: true

require_relative '../services/repository_service'

class UpdateInfoRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find repository_id

    RepositoryService.update repository

    if repository.has_webhook
      check = repository.checks.create!
      CheckRepositoryJob.perform_later check.id
    else
      GithubHookCreateJob.perform_later repository.github_id, repository.user.token
    end
  end
end
