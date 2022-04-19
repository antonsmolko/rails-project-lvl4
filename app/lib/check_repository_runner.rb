# frozen_string_literal: true

class CheckRepositoryRunner
  COMMAND_MAP = {
    javascript: 'npx eslint -f json',
    ruby: 'rubocop --format json'
  }.freeze

  def self.start(repository)
    dir_path = CloneRepository.start repository

    raise StandardError, "Directory does not exist: #{dir_path}" unless Dir.exist? dir_path

    lint_cmd = COMMAND_MAP[repository.language.to_sym]

    output, exit_status = Open3.popen3("cd #{dir_path} && #{lint_cmd}") { |_i, stdout, _e, wait_thr| [stdout.read, wait_thr.value] }

    raise StandardError, "Check repository error: #{dir_path}" unless exit_status.exitstatus.zero?

    JSON.parse(output)
  end
end
