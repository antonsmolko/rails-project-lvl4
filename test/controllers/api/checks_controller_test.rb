# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'create' do
    repository = repositories :js

    post api_checks_path repository: { full_name: repository.full_name }
    assert_response :success
  end
end
