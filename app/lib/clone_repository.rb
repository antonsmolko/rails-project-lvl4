# frozen_string_literal: true

class CloneRepository
  def self.start(repository)
    tmp_repos_dir_name = 'repos'
    tmp_repos_path = Rails.root.join('tmp', tmp_repos_dir_name)

    FileUtils.mktmpdir(tmp_repos_dir_name) unless Dir.exist? tmp_repos_path

    repo_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}")

    FileUtils.rm_r repo_path if Dir.exist? repo_path
    FileUtils.mkdir_p repo_path

    dir_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}").to_s

    clone_cmd = "git clone #{repository.clone_url}"
    Open3.capture3("#{clone_cmd} #{dir_path}")

    dir_path
  end
end
