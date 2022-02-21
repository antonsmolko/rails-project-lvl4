# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  include Import['repository_check_runner']

  protect_from_forgery except: :index

  def index
    repository = Repository.find_by(github_id: payload_params['repository']['id'])
    repository_check_runner.start repository

    render status: :ok, json: { status: 'ok' }
  end

  private

  def payload_params
    JSON.parse(params[:payload])
  end
end
