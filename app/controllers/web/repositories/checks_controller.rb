# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  include Import['repository_check_runner']
  def start
    repo = repository_resource

    check = repo.checks.create!

    repository_check_runner.start check, repo.id

    check.reload

    redirect_to repository_path repo
  end

  def show
    @check = Repository::Check.find params[:check_id]
  end
end
