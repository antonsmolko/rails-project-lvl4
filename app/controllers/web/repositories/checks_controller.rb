# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def create
    repository = repository_resource
    check = repository.checks.create!
    authorize check

    CheckRepositoryJob.perform_later check.id

    redirect_to repository_path repository
  end

  def show
    @check = resource
    authorize @check
  end

  private

  def resource
    Repository::Check.find params[:id]
  end
end
