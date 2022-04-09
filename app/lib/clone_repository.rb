# frozen_string_literal: true

class CloneRepository
  def self.start(repository)
    repo_path = File.join('tmp/repos', repository.full_name)

    clone_cmd = "git clone #{repository.clone_url}"
    Open3.capture3("#{clone_cmd} #{repo_path}")

    repo_path
  end
end
