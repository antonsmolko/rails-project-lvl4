# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  include Import['repository_check_runner']

  protect_from_forgery except: :index

  def index
    repository = Repository.find_by(github_id: github_id_params)
    repository_check_runner.start repository

    render status: :ok, json: { status: 'ok' }
  end

  private

  def github_id_params
    nil unless params[:payload].present?
    payload = JSON.parse(params[:payload])

    payload[:repository][:id]
  end
end
