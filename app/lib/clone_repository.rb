# frozen_string_literal: true

class CloneRepository
  def self.start(repository)
    repo_path = File.join(Dir.tmpdir, 'repos', repository.full_name).to_s

    clone_cmd = "git clone #{repository.clone_url}"

    FileUtils.rm_r repo_path if Dir.exist? repo_path

    Open3.capture3("#{clone_cmd} #{repo_path}")

    repo_path
  end
end
