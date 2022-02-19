class RepositoryCheckJob < ApplicationJob
  queue_as :default

  attr_accessor :language

  def perform(check, dir, last_commit_id, language)
    raise StandardError unless Dir.exist? dir

    check.check!

    lint_cmd = command_map[language.to_sym]

    stdout = Open3.capture3("#{lint_cmd} #{dir}") { |_stdin, stdout, _stderr, wait_thr| [stdout.read, wait_thr.value] }

    parsed_data = JSON.parse(stdout[0])

    data = StdoutSerializer.build parsed_data, language
    issues_count = data[:issues_count]

    if check.update!(
      reference_id: last_commit_id,
      passed: issues_count == 0,
      listing: data[:listing],
      issues_count: issues_count
    )
      check.finish!
    else
      StandardError
    end
  rescue StandardError
    check.mark_as_failed!
  end

  private

  def command_map
    {
      javascript: 'npx eslint -c .eslintrc.yml -f json',
      ruby: 'rubocop --format json'
    }
  end
end
