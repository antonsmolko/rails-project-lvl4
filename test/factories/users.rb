# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'MyString' }
    nickname { 'MyString' }
    token { 'MyString' }
  end
end
