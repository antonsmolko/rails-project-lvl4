# frozen_string_literal: true

require 'test_helper'

class UpdateInfoRepositoryJobTest < ActiveJob::TestCase
  setup do
    @repository = repositories :ruby
  end

  test '#update' do
    UpdateInfoRepositoryJob.perform_now @repository.id
    assert { @repository.checks.size == 1 }
    assert { @repository.name == 'rails-project-lvl1' }
    assert { @repository.owner_login == 'johndoe' }
  end
end
