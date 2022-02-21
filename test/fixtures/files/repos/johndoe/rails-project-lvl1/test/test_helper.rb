# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest/autorun'

# Module FixtureHelper
module FixtureHelper
  def read_fixture_file(filename)
    File.open(File.expand_path("../test/fixtures/#{filename}", __dir__), 'r').read
  end
end

class HexletCodeTest < Minitest::Test
  include FixtureHelper
end
