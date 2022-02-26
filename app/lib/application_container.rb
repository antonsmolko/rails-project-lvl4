# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :repository_check_runner, -> { CheckRepositoryRunnerStub }
  else
    register :repository_check_runner, -> { CheckRepositoryRunner }
  end
end
