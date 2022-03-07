# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  include Import['github_hook_create_runner', 'github_repositories_api']

  before_action :require_signed_in_user!

  AVAILABLE_LANGUAGES = %(javascript ruby)

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = repository_resource
    authorize @repository
  end

  def new
    client_repos = github_repositories_api.get current_user.token

    @repositories = client_repos.select { |r| available_language? r[:language] }
    @repository = Repository.new
  end

  def create
    if repository_params[:github_id].blank?
      redirect_to new_repository_path, notice: t('notice.repositories.github_cant_be_blank')
      return
    end

    github_id = repository_params[:github_id].to_i

    if current_user.repositories.where(github_id: github_id).first_or_create!
      github_hook_create_runner.start github_id, current_user.token
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
    !language.nil? && AVAILABLE_LANGUAGES.include?(language.downcase!)
  end
end
