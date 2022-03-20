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

    output = Open3.capture3("cd #{dir_path} && #{lint_cmd}") { |_stdin, stdout| stdout.read }

    JSON.parse(output[0])
  end
end
