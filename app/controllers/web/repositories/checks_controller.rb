# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  include Import['repository_check_runner']

  def create
    repository = repository_resource
    check = repository.checks.create!({ language: repository.language })

    authorize check

    repository_check_runner.start check

    redirect_to repository_path repository.reload
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
