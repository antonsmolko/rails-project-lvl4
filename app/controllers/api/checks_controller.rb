# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  include Import['repository_check_runner']

  protect_from_forgery except: :index

  def index
    repository = Repository.find_by(github_id: github_id_params)
    if repository.present?
      repository_check_runner.start repository

      render status: :ok, json: { status: 'ok' }
    else
      render status: :unprocessable_entity, json: { status: 'unprocessable_entity' }
    end
  end

  private

  def github_id_params
    nil if params[:payload].blank?
    payload = JSON.parse(params[:payload])

    payload[:repository][:id]
  end
end
