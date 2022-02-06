# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :owner_login, presence: true
  validates :full_name, presence: true
  validates :url, presence: true
  validates :pushed_at, presence: true
end
