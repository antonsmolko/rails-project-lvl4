# frozen_string_literal: true

require 'test_helper'

class GithubHookCreateJobTest < ActiveJob::TestCase
  setup do
    @repository = repositories :ruby
    @access_token = '12345'
  end

  test '#create' do
    response = GithubHookCreateJob.perform_now @repository.id, @access_token
    assert { response[0] == 'success' }
  end
end
