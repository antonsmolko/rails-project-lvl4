# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    repository = Repository.find_by(full_name: repository_params[:full_name])

    if repository.blank?
      return head :not_found
    end

    repository.update! has_webhook: true

    UpdateInfoRepositoryJob.perform_later repository.id

    head :ok
  end

  private

  def repository_params
    params.require(:repository).permit(:full_name)
  end
end
