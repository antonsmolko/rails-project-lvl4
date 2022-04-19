# frozen_string_literal: true

class CheckRepositoryRunner
  def self.start(repository)
    path_to_repository = CloneRepository.start repository

    raise StandardError, "Directory does not exist: #{path_to_repository}" unless Dir.exist? path_to_repository

    command_map = {
      javascript: "npx eslint #{path_to_repository} --format=json --config ./.eslintrc.yml  --no-eslintrc",
      ruby: "bundle exec rubocop #{path_to_repository} --format=json --config ./.rubocop.yml"
    }

    command = command_map[repository.language.to_sym]

    output = Open3.popen3(command) { |_i, stdout| stdout.read }

    # @TODO: Всегда возвращает exitstatus > 0
    # output, exit_status = Open3.popen3(command) { |_i, stdout, _e, wait_thr| [stdout.read, wait_thr.value] }
    # raise StandardError, "Check repository error: #{path_to_repository}" unless exit_status.exitstatus.zero?

    JSON.parse(output)
  end
end
