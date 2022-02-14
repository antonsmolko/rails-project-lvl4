class RepositoryCloneJob < ApplicationJob
  queue_as :default

  attr_accessor :last_commit_id, :dir

  after_perform do |job|
    RepositoryEslintCheckJob.perform_later(job.arguments.first, @dir, @last_commit_id)
  end

  def perform(check, repository_id)
    repository = Repository.find repository_id

    @dir = "tmp/repos/#{repository.owner_login}/#{repository.name}"

    clone_cmd = "git clone #{repository.git_url}"
    get_last_commit_id_cmd = 'git rev-parse --short HEAD'
    Open3.capture3("#{clone_cmd} #{@dir}")
    @last_commit_id = Open3.popen3(get_last_commit_id_cmd, chdir: @dir) { |_stdin, stdout| stdout.read.chomp }
  rescue StandardError
    check.mark_as_failed!
  end
end
