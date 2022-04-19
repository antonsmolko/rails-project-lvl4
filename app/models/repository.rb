# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  has_many :checks, dependent: :destroy
  belongs_to :user

  AVAILABLE_LANGUAGES = %w[javascript ruby].freeze

  enumerize :language, in: AVAILABLE_LANGUAGES

  validates :github_id, presence: true

  paginates_per 5
end
