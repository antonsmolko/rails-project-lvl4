class RepositoryEslintCheckJob < ApplicationJob
  queue_as :default

  def perform(check, dir, last_commit_id)
    raise StandardError unless Dir.exist? dir

    check.check!

    lint_cmd = "npx eslint -c .eslintrc.yml -f json"
    stdout = Open3.capture3("#{lint_cmd} #{dir}") { |_stdin, stdout, _stderr, wait_thr| [stdout.read, wait_thr.value] }
    listing = JSON.parse(stdout[0])

    if check.update!(
      reference_id: last_commit_id,
      passed: listing.empty?,
      listing: listing,
      issues_count: listing.reduce(0) {|acc, file| acc + file['messages'].count }
    )
      check.finish!
    end
  rescue StandardError
    check.mark_as_failed!
  end
end
