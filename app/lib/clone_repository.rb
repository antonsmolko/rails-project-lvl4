# frozen_string_literal: true

class CloneRepository
  def self.start(repository)
    repo_path = File.join(Dir.tmpdir, 'repos', repository.full_name).to_s

    clone_cmd = "git clone #{repository.clone_url}"

    FileUtils.rm_r repo_path if Dir.exist? repo_path

    exit_status = Open3.popen3("#{clone_cmd} #{repo_path}") { |_stdin, _, _stderr, wait_thr| wait_thr.value }

    if exit_status.exitstatus != 0
      throw StandardError.new("Clone repository error: #{exit_status}")
    end

    repo_path
  end
end
