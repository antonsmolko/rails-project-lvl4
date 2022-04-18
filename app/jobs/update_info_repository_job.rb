# frozen_string_literal: true

class UpdateInfoRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find repository_id

    RepositoryService.update repository

    GithubHookCreateJob.perform_later repository.github_id, repository.user.token
  end
end
