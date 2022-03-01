# frozen_string_literal: true

FIXTURES_MAPPING = {
  javascript: 'test/fixtures/files/check_eslint_response.json',
  ruby: 'test/fixtures/files/check_rubocop_response.json'
}.freeze

class CheckRepositoryRunnerStub
  def self.start(check_id)
    check = Repository::Check.find check_id
    language = check.repository.language

    check.check!

    response = File.read(Rails.root.join(FIXTURES_MAPPING[language.try :to_sym]) || '')
    stdout = JSON.parse(response)

    data = StdoutSerializer.build stdout, language
    issues_count = data[:issues_count]
    # last_commit_id = 'c5b480f'

    if check.update!(
      # reference_id: last_commit_id,
      passed: issues_count.zero?,
      listing: data[:listing],
      issues_count: issues_count
    )
      check.finish!
    else
      check.mark_as_failed!
    end
  end
end