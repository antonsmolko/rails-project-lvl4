# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  include Import['octokit_client_api']

  before_action :require_signed_in_user!

  def index
    @repositories = current_user.repositories.page params[:page]
  end

  def show
    @repository = repository_resource
    @checks = @repository.checks.order created_at: :desc
    authorize @repository
  end

  def new
    client = octokit_client_api.new current_user.token

    @repositories = Rails.cache.fetch("user_#{current_user.id}_repos", expires_in: 12.hours) do
      client.repos.select { |r| available_language? r[:language] }
    end

    @repository = Repository.new
  end

  def create
    github_id = repository_params[:github_id]

    if github_id.nil?
      redirect_to new_repository_path, notice: t('notice.repositories.github_cant_be_blank')
      return
    end

    repository = current_user.repositories.where(github_id: github_id.to_i).first_or_create

    if repository
      UpdateInfoRepositoryJob.perform_later repository.id
      redirect_to repositories_path, notice: t('notice.repositories.added')
    else
      redirect_to new_repository_path, notice: t('notice.repositories.create_failed')
    end
  end

  private

  def repository_resource
    Repository.find params[:id]
  end

  def repository_params
    params.require(:repository).permit(:github_id)
  end

  def available_language?(language)
    language.present? && Repository::AVAILABLE_LANGUAGES.include?(language.downcase)
  end
end
