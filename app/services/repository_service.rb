# frozen_string_literal: true

class RepositoryService
  def self.update(repository)
    octokit_client_api = ApplicationContainer[:octokit_client_api]
    client = octokit_client_api.new repository.user.token

    response = client.repo repository.github_id
    repository_default_branch = client.branch(response['id'], response['default_branch'])

    last_commit_id = repository_default_branch['commit']['sha'][0, 7]

    response[:last_commit_id] = last_commit_id

    repository.update! RepositoryService.serialize_repository_response response
  end

  def self.serialize_repository_response(data)
    {
      name: data['name'],
      owner_login: data['owner']['login'],
      full_name: data['full_name'],
      url: data['url'],
      html_url: data['html_url'],
      language: data['language'].downcase,
      pushed_at: data['pushed_at'],
      clone_url: data['clone_url'],
      last_commit_id: data['last_commit_id']
    }
  end
end
