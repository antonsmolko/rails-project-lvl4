# frozen_string_literal: true

class CheckRepositoryRunner
  COMMAND_MAP = {
    javascript: 'npx eslint -c .eslintrc.yml -f json',
    ruby: 'rubocop --format json'
  }.freeze

  def self.start(repository)
    dir_path = CloneRepository.start repository

    raise StandardError unless Dir.exist? dir_path

    lint_cmd = COMMAND_MAP[repository.language.to_sym]

    output = Open3.capture3("#{lint_cmd} #{dir_path}") { |_stdin, stdout| stdout.read }

    JSON.parse(output[0])
  end
end
