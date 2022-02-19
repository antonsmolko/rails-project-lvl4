# frozen_string_literal: true

require 'test_helper'

class Web::RegistrationControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    get new_user_registration_path
    assert_response :success
  end
end
