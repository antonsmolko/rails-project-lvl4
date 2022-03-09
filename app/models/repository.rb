# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  has_many :checks, dependent: :destroy
  belongs_to :user, dependent: :destroy

  AVAILABLE_LANGUAGES = %w[javascript ruby].freeze

  enumerize :language, in: AVAILABLE_LANGUAGES, skip_validations: true

  validates :github_id, presence: true
  # validates :name, presence: true
  # validates :full_name, presence: true
  # validates :owner_login, presence: true
  # validates :url, presence: true
  # validates :html_url, presence: true
  # validates :language, presence: true
  # validates :pushed_at, presence: true
  # validates :git_url, presence: true
end
