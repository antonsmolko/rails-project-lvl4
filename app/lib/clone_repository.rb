# frozen_string_literal: true

class CloneRepository
  def self.start(repository)
    repo_path = File.join(Dir.tmpdir, 'repos', repository.full_name).to_s

    clone_cmd = "git clone #{repository.clone_url}"

    FileUtils.rm_r repo_path if Dir.exist? repo_path

    exit_status = Open3.popen3("#{clone_cmd} #{repo_path}") { |_i, _o, _e, wait_thr| wait_thr.value }

    raise StandardError, "Clone repository error: #{exit_status}" unless exit_status.exitstatus.zero?

    repo_path
  end
end
