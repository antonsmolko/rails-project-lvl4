# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id, dir)
    check = Repository::Check.find check_id
    raise StandardError unless Dir.exist? dir

    check.check!

    lint_cmd = command_map[check.repository.language.to_sym]

    output = Open3.capture3("#{lint_cmd} #{dir}") { |_stdin, stdout| stdout.read }

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
  rescue StandardError
    check ||= Repository::Check.find check_id
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
