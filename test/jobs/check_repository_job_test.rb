# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryJobTest < ActiveJob::TestCase
  setup do
    @repository = repositories :ruby
    @check = @repository.checks.create!
  end

  test '#check' do
    CheckRepositoryJob.perform_now @repository.id
    @check.reload
    assert { @repository.checks.last == @check }
    assert { @check.aasm_state == 'finished' }
  end
end
