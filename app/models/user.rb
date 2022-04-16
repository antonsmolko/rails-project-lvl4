# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories, dependent: :destroy
  has_many :checks, through: :repositories, dependent: :destroy
end
