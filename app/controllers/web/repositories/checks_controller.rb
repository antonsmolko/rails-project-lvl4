# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def create
    repository = repository_resource

    # authorize repository
    repository.checks.create!

    UpdateInfoRepositoryJob.perform_later repository

    redirect_to repository_path repository
  end

  def show
    @check = check_resource
  end

  private

  def repository_resource
    Repository.find params[:repository_id]
  end

  def check_resource
    Repository::Check.find params[:id]
  end
end
