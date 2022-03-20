# frozen_string_literal: true

class CloneRepository
  def self.start(repository)
    tmp_repos_path = File.join(Dir.tmpdir, ENV['APP_NAME'])
    FileUtils.mkdir(tmp_repos_path) unless Dir.exist? tmp_repos_path

    repo_path = File.join(tmp_repos_path, repository.full_name)

    FileUtils.rm_r repo_path if Dir.exist? repo_path
    FileUtils.mkdir_p repo_path

    clone_cmd = "git clone #{repository.clone_url}"
    Open3.capture3("#{clone_cmd} #{repo_path}")

    repo_path
  end
end
