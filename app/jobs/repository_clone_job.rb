class RepositoryCloneJob < ApplicationJob
  queue_as :default

  attr_accessor :last_commit_id, :dir_path

  after_perform do |job|
    RepositoryEslintCheckJob.perform_later(job.arguments.first, @dir_path, @last_commit_id)
  end

  def perform(check, repository_id)
    repository = Repository.find repository_id
    tmp_repos_path = Rails.root.join('tmp/repos')

    Dir.mkdir(tmp_repos_path) unless Dir.exist? tmp_repos_path

    repo_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}")

    FileUtils.rm_r repo_path if Dir.exist? repo_path
    Dir.mkdir(repo_path)

    @dir_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}").to_s
    clone_cmd = "git clone #{repository.git_url}"
    get_last_commit_id_cmd = 'git rev-parse --short HEAD'
    Open3.capture3("#{clone_cmd} #{@dir_path}")
    @last_commit_id = Open3.popen3(get_last_commit_id_cmd, chdir: @dir_path) { |_stdin, stdout| stdout.read.chomp }
  rescue StandardError
    check.mark_as_failed!
  end
end
