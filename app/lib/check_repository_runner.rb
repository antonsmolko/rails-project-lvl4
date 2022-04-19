# frozen_string_literal: true

class CheckRepositoryRunner
  COMMAND_MAP = {
    javascript: 'npx eslint -f json',
    ruby: 'rubocop --format json'
  }.freeze

  def self.start(repository)
    dir_path = CloneRepository.start repository

    raise StandardError unless Dir.exist? dir_path

    lint_cmd = COMMAND_MAP[repository.language.to_sym]

    output, exit_status = Open3.popen3("cd #{dir_path} && #{lint_cmd}") { |_i, stdout, _e, wait_thr| [stdout.read, wait_thr.value] }

    if exit_status.exitstatus != 0
      throw StandardError.new("Check repository error: #{exit_status}")
    end

    JSON.parse(output)
  end
end
