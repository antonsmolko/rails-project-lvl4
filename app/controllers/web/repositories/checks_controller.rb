# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  include Import['repository_check_runner']

  def start
    repository = repository_resource

    repository_check_runner.start repository

    redirect_to repository_path repository.reload
  end

  def show
    @check = Repository::Check.find params[:check_id]
  end
end
