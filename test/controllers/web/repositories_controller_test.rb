# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)

    @repository = repositories :one
    @attrs = {
      full_name: 'octocat/Hello-World'
    }
  end

  test 'index' do
    get repositories_url
    assert_response :success
  end

  test 'show' do
    get repository_url @repository
    assert_response :success
  end

  test 'create' do
    uri_template = Addressable::Template.new 'https://api.github.com/user/repos'

    response = load_fixture('files/response.json')

    stub_request(:get, uri_template)
      .to_return(
        status: 200,
        body: response,
        headers: { 'Content-Type' => 'application/json' }
      )

    post repositories_url, params: {
      repo: @attrs
    }

    assert_response :redirect

    repository = Repository.find_by! full_name: @attrs[:full_name]
    assert { repository.name.present? }

    response_json = JSON.parse(response).first

    assert { @attrs[:full_name] == repository.full_name }
    assert { response_json['owner']['login'] == repository.owner_login }
  end
end
