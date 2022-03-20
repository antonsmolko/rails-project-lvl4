# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    repository = repositories :one

    post api_checks_path repository: { full_name: repository.full_name }
    assert_response :success
  end
end
