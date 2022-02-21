# frozen_string_literal: true

class StdoutSerializer
  def self.build(stdout, language)
    serializer = case language
                 when 'javascript' then StdoutEslintSerializer.new
                 when 'ruby' then StdoutRubocopSerializer.new
                 end

    throw StandardError.new("Unknown language: #{language}") if serializer.nil?

    serializer.build stdout
  end
end
