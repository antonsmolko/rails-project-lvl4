# frozen_string_literal: true

class RepositoryCloneJob < ApplicationJob
  queue_as :default

  attr_accessor :last_commit_id, :dir_path, :language

  after_perform do |job|
    RepositoryCheckJob.perform_later(job.arguments.first, @dir_path, @last_commit_id, @language)
  end

  def perform(check)
    repository = check.repository
    tmp_repos_path = Rails.root.join('tmp/repos')

    @language = repository.language.downcase!

    Dir.mkdir(tmp_repos_path) unless Dir.exist? tmp_repos_path

    repo_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}")

    FileUtils.rm_r repo_path if Dir.exist? repo_path
    FileUtils.mkdir_p repo_path

    @dir_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}").to_s
    clone_cmd = "git clone #{repository.git_url}"
    Open3.capture3("#{clone_cmd} #{@dir_path}")

    @last_commit_id = Open3.popen3('git rev-parse --short HEAD', chdir: @dir_path) do |_stdin, stdout|
      stdout.read.chomp
    end
  rescue StandardError
    check.mark_as_failed!
  end
end
