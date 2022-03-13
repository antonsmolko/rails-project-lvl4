# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  protect_from_forgery except: :index

  def index
    repository = Repository.find_by!(full_name: repository_resource[:full_name])

    if repository.blank?
      render status: :unprocessable_entity, json: { status: 'unprocessable_entity' }
    end

    repository.update! has_webhook: true

    UpdateInfoRepositoryJob.perform_later repository

    render status: :ok, json: { status: 'ok' }
  end

  private

  def repository_resource
    params.require(:repository).permit(:full_name)
  end
end
