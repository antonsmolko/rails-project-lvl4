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
    full_name = repository_params[:full_name]

    if full_name.nil?
      redirect_to new_repository_path, notice: t('notice.repositories.github_cant_be_blank')
      return
    end

    if current_user.repositories.where(full_name: full_name).first_or_create!
      github_hook_create_runner.start full_name, current_user.token
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
    params.require(:repository).permit(:full_name)
  end

  def available_language?(language)
    !language.nil? && AVAILABLE_LANGUAGES.include?(language.downcase!)
  end
end
