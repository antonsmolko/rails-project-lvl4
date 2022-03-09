# frozen_string_literal: true

FIXTURES_MAPPING = {
  javascript: 'test/fixtures/files/check_eslint_response.json',
  ruby: 'test/fixtures/files/check_rubocop_response.json'
}.freeze

class CheckRepositoryRunnerStub
  def self.start(repository)
    response = File.read(Rails.root.join(FIXTURES_MAPPING[repository.language.to_sym]) || '')
    JSON.parse(response)
  end
end
