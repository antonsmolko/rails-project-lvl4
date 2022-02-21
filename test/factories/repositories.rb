# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    repo_name { 'MyString' }
    owner_name { 'MyString' }
    link { 'MyString' }
    language { 'MyString' }
    last_check { false }
  end
end
