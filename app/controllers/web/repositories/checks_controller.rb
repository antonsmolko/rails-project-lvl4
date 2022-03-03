# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  include Import['check_repository_runner']

  def create
    repository = repository_resource
    check = repository.checks.create!

    authorize check

    check_repository_runner.start check

    redirect_to repository_path repository
  end

  def show
    @check = check_resource
    authorize @check
  end

  private

  def repository_resource
    Repository.find params[:repository_id]
  end

  def check_resource
    Repository::Check.find params[:id]
  end
end
