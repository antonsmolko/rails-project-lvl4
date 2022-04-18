# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  has_many :checks, -> { order(created_at: :desc) }, dependent: :destroy
  belongs_to :user

  AVAILABLE_LANGUAGES = %w[javascript ruby].freeze

  enumerize :language, in: AVAILABLE_LANGUAGES, skip_validations: true

  validates :github_id, presence: true

  paginates_per 5
end
