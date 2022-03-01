# frozen_string_literal: true

class CloneRepositoryJob < ApplicationJob
  queue_as :default

  attr_accessor :dir_path

  after_perform do |job|
    CheckRepositoryJob.perform_later(job.arguments.first, @dir_path)
  end

  def perform(check_id)
    check = Repository::Check.find check_id
    repository = check.repository
    tmp_repos_path = Rails.root.join('tmp/repos')

    Dir.mkdir(tmp_repos_path) unless Dir.exist? tmp_repos_path

    repo_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}")

    FileUtils.rm_r repo_path if Dir.exist? repo_path
    FileUtils.mkdir_p repo_path

    @dir_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}").to_s
    clone_cmd = "git clone #{repository.git_url}"
    Open3.capture3("#{clone_cmd} #{@dir_path}")
  rescue StandardError
    check ||= Repository::Check.find check_id
    check.mark_as_failed!
  end
end
