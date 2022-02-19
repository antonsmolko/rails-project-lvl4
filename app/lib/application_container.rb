# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :repository_check_runner, -> { RepositoryCheckRunnerStub }
  else
    register :repository_check_runner, -> { RepositoryCheckRunner }
  end
end
