# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)
  end

  test 'index' do
    get repositories_url
    assert_response :success
  end

  test 'show' do
    repository = repositories :one
    get repository_url repository
    assert_response :success
  end

  test 'new' do
    get new_repository_url
    assert_response :success
  end

  test 'create' do
    attrs = {
      github_id: 1_296_269
    }

    post repositories_url, params: {
      repository: attrs
    }

    assert_response :redirect

    repository = Repository.find_by! github_id: attrs[:github_id]
    assert { repository.github_id.present? }
    assert { repository.language == 'ruby' }
    assert { repository.full_name == 'Hexlet/hexlet-cv' }
    assert { attrs[:github_id] == repository.github_id }
  end
end
