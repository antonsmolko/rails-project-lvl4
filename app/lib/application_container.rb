# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :check_repository_runner, -> { CheckRepositoryRunnerStub }
    register :github_hook_create_runner, -> { GithubHookCreateRunnerStub }
    register :github_repositories_api, -> { GithubRepositoriesApiStub }
  else
    register :check_repository_runner, -> { CheckRepositoryRunner }
    register :github_hook_create_runner, -> { GithubHookCreateRunner }
    register :github_repositories_api, -> { GithubRepositoriesApi }
  end
end
