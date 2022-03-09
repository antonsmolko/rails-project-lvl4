# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :check_repository_runner, -> { CheckRepositoryRunnerStub }
    register :octokit_client_api, -> { OctokitClientApiStub }
  else
    register :check_repository_runner, -> { CheckRepositoryRunner }
    register :octokit_client_api, -> { OctokitClientApi }
  end
end
