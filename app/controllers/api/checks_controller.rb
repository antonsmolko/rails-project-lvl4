# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  include Import['check_repository_runner']

  protect_from_forgery except: :index

  def index
    repository = Repository.find_by!(full_name: repository_resource['full_name'])

    if repository.blank?
      render status: :unprocessable_entity, json: { status: 'unprocessable_entity' }
    end

    check = repository.checks.create!

    check_repository_runner.start check

    render status: :ok, json: { status: 'ok' }
  end

  private

  def repository_resource
    request_params = params[:payload].nil? ? params : JSON.parse(params[:payload])
    request_params['repository']
  end
end
