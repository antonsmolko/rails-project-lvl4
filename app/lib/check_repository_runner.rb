# frozen_string_literal: true

class CheckRepositoryRunner
  def self.start(repository)
    path_to_repository = CloneRepository.start repository

    raise StandardError, "Directory does not exist: #{path_to_repository}" unless Dir.exist? path_to_repository

    command_map = {
      javascript: "npx eslint #{path_to_repository} --format=json --config ./.eslintrc.yml  --no-eslintrc",
      ruby: 'rubocop --format json'
    }

    command = command_map[repository.language.to_sym]

    output = Open3.popen3(command) { |_i, stdout| stdout.read }

    # raise StandardError, "Check repository error: #{path_to_repository}" unless exit_status.exitstatus.zero?

    JSON.parse(output)
  end
end
