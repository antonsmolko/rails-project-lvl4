# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  protect_from_forgery except: :index

  def index
    repository = Repository.find_by(github_id: github_id_params)

    if repository.blank?
      render status: :unprocessable_entity, json: { status: 'unprocessable_entity' }
    end

    check = repository.checks.create!

    CheckRepositoryRunner.start check

    render status: :ok, json: { status: 'ok' }
  end

  private

  def github_id_params
    nil if payload_params.blank?
    payload_params['repository']['id']
  end

  def payload_params
    nil if params[:payload].blank?
    JSON.parse(params[:payload])
  end
end
