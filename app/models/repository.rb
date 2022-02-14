# frozen_string_literal: true

class Repository < ApplicationRecord
  has_many :checks
  belongs_to :user

  validates :owner_login, presence: true
  validates :full_name, presence: true
  validates :url, presence: true
  validates :pushed_at, presence: true
  validates :git_url, presence: true
end
