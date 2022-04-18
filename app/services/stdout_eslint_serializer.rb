# frozen_string_literal: true

class StdoutEslintSerializer
  def build(data)
    files = data.filter { |file| (file['errorCount']).positive? }

    {
      issues_count: files.reduce(0) { |acc, file| acc + file['errorCount'] },
      listing: files.map { |file| serialize_file file }
    }
  end

  private

  def serialize_file(file)
    {
      path: file['filePath'],
      messages: file['messages'].filter { |message| message['severity'] > 1 }.map do |message|
        serialize_message message
      end
    }
  end

  def serialize_message(message)
    {
      message: message['message'],
      rule: message['ruleId'],
      line: message['line'],
      column: message['column']
    }
  end
end
