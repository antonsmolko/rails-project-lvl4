# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  protect_from_forgery except: :create

  def create
    repository = Repository.find_by(full_name: repository_params[:full_name])

    if repository.blank?
      return head :not_found
    end

    check = repository.checks.create
    CheckRepositoryJob.perform_later check.id

    head :ok
  end

  private

  def repository_params
    params.require(:repository).permit(:full_name)
  end
end
