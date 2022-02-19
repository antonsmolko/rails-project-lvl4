# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :require_signed_in_user!

  AVAILABLE_LANGUAGES = %[javascript ruby]

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = repository_resource
  end

  def new
    client = Octokit::Client.new access_token: current_user.token
    @repositories = client.repos.select { |r| is_available_language? r[:language] }
    @repository = Repository.new
  end

  def create
    unless repository_params[:full_name].present?
      redirect_to new_repository_path, notice: t('notice.repositories.github_cant_be_blank')
      return
    end

    client = Octokit::Client.new access_token: current_user.token
    repository = client.repos.select {|r| r[:full_name] == repository_params[:full_name] }.first

    if current_user.repositories.where(full_name: repository_params[:full_name]).first_or_create! do |r|
      r.name = repository.name
      r.owner_login = repository.owner.login
      r.full_name = repository.full_name
      r.url = repository.url
      r.html_url = repository.html_url
      r.language = repository.language
      r.pushed_at = repository.pushed_at
      r.git_url = repository.git_url
    end
      redirect_to repositories_path, notice: t('notice.repositories.added')
    else
      render :new
    end
  end

  private

  def repository_resource
    Repository.find params[:id]
  end

  def repository_params
    params.require(:repo).permit(:full_name)
  end

  def is_available_language? language
    !language.nil? && AVAILABLE_LANGUAGES.include?(language.downcase!)
  end
end
