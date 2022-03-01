# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :check_repository_runner, -> { CheckRepositoryRunnerStub }
  else
    register :check_repository_runner, -> { CheckRepositoryRunner }
  end
end
