# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    repository = Repository.find_by!(full_name: repository_resource[:full_name])

    if repository.blank?
      head :unprocessable_entity
    end

    repository.update! has_webhook: true

    UpdateInfoRepositoryJob.perform_later repository.id

    head :ok
  end

  private

  def repository_resource
    params.require(:repository).permit(:full_name)
  end
end
