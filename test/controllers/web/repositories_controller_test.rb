# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)

    @repository = repositories :one
    @attrs = {
      github_id: 1_296_269,
      full_name: 'johndoe/frontend-project-lvl1'
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

  test 'new' do
    get new_repository_url
    assert_response :success
  end

  test 'create' do
    uri_template = Addressable::Template.new 'https://api.github.com/user/repos'

    response = load_fixture('files/response.json')

    stub_request(:get, uri_template)
      .with(
        headers: {
          'Accept' => 'application/vnd.github.v3+json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'token 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',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Octokit Ruby Gem 4.22.0'
        }
      )
      .to_return(
        status: 200,
        body: response,
        headers: { 'Content-Type' => 'application/json' }
      )

    post repositories_url, params: {
      repository: @attrs
    }

    assert_response :redirect

    repository = Repository.find_by! full_name: @attrs[:full_name]
    assert { repository.full_name.present? }
    assert { @attrs[:full_name] == repository.full_name }
  end
end
