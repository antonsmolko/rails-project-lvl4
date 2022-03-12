# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @user = users :one
    sign_in(@user)

    @check = repository_checks :one
    @repository_js = repositories :js
    @repository_ruby = repositories :ruby
  end

  test '#show' do
    get repository_check_path(@check.repository, @check)
    assert_response :success
  end

  test '#start_eslint_check' do
    post repository_checks_path @repository_js

    assert_response :redirect

    perform_enqueued_jobs

    repository_last_check = @repository_js.reload.checks.last
    assert { repository_last_check.aasm_state == 'finished' }
    assert { repository_last_check.passed == true }
    assert { repository_last_check.issues_count.zero? }
  end

  test '#start_rubocop_check' do
    post repository_checks_path @repository_ruby

    assert_response :redirect

    perform_enqueued_jobs

    repository_last_check = @repository_ruby.reload.checks.last
    assert { repository_last_check.aasm_state == 'finished' }
    assert { repository_last_check.passed == true }
    assert { repository_last_check.issues_count.zero? }
  end
end
