# frozen_string_literal: true

class StdoutRubocopSerializer
  def build(data)
    {
      issues_count: data['summary']['offense_count'],
      listing: data['files'].filter { |file| !file['offenses'].empty? }.map { |file| serialize_file file }
    }
  end

  private

  def serialize_file(file)
    {
      path: file['path'],
      messages: file['offenses'].map { |message| serialize_message message }
    }
  end

  def serialize_message(offense)
    {
      message: offense['message'],
      rule: offense['cop_name'],
      line: offense['location']['line'],
      column: offense['location']['column']
    }
  end
end
