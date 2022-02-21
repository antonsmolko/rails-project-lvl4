# frozen_string_literal: true

class RepositoryCheckRunnerStub
  def self.start(repository)
    check = repository.checks.create!

    check.check!

    dir_path = Rails.root.join('test/fixtures/files/repos/', repository.owner_login, repository.name).to_s

    unless Dir.exist? dir_path
      check.mark_as_failed!
      throw StandardError.new("Directory #{dir_path} does not exist")
    end

    last_commit_id = Open3.popen3('git rev-parse --short HEAD', chdir: dir_path) { |_stdin, stdout| stdout.read.chomp }
    language = repository.language.downcase!

    RepositoryCheckJob.perform_later(check, dir_path, last_commit_id, language)
  end
end
