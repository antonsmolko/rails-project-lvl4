# frozen_string_literal: true

class RepositoryCheckRunnerStub
  def self.start(check, _)
    check.check!

    response = File.read(Rails.root.join('test/fixtures/files/check_response.json'))
    listing = JSON.parse(response)
    last_commit_id = 'c5b480f'

    if check.update!(
      reference_id: last_commit_id,
      passed: listing.empty?,
      listing: listing,
      issues_count: listing.reduce(0) {|acc, file| acc + file['messages'].count }
    )
      check.finish!
    else
      check.mark_as_failed!
    end
  end
end
