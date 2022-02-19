# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)

    @check = repository_checks :one
    @repository = repositories :one
  end

  test '#show' do
    get check_path(@check.repository, @check)
    assert_response :success
  end

  test '#start' do
    post start_check_repository_path @repository

    assert_response :redirect

    repository_last_check = @repository.checks.last
    assert { repository_last_check.state == 'finished' }
    assert { repository_last_check.issues_count == 28 }
  end
end
