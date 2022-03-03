# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check)
    dir_path = clone_repository check

    raise StandardError unless Dir.exist? dir_path

    check.check!

    lint_cmd = command_map[check.repository.language.to_sym]

    output = Open3.capture3("#{lint_cmd} #{dir_path}") { |_stdin, stdout| stdout.read }

    parsed_data = JSON.parse(output[0])

    data = StdoutSerializer.build parsed_data, check.repository.language

    issues_count = data[:issues_count]
    passed = issues_count.zero?

    if check.update!(
      passed: passed,
      listing: data[:listing],
      issues_count: issues_count
    )
      check.finish!
    else
      StandardError
    end

    check.send_failed unless passed
  rescue StandardError => e
    logger.debug "check repository job error: #{e.message}"
    # rubocop:disable Rails/Output
    p "check repository job error: #{e.message}"
    # rubocop:enable Rails/Output
    check ||= Repository::Check.find check_id
    check.mark_as_failed!
  end

  private

  def clone_repository(check)
    repository = check.repository
    tmp_repos_path = Rails.root.join('tmp/repos')

    Dir.mkdir(tmp_repos_path) unless Dir.exist? tmp_repos_path

    repo_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}")

    FileUtils.rm_r repo_path if Dir.exist? repo_path
    FileUtils.mkdir_p repo_path

    dir_path = Rails.root.join("tmp/repos/#{repository.owner_login}/#{repository.name}").to_s

    clone_cmd = "git clone #{repository.git_url}"
    Open3.capture3("#{clone_cmd} #{dir_path}")

    dir_path
  end

  def command_map
    {
      javascript: 'npx eslint -c .eslintrc.yml -f json',
      ruby: 'rubocop --format json'
    }
  end
end
