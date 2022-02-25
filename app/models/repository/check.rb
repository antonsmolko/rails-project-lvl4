# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

  aasm whiny_transitions: false do
    state :created, initial: true
    state :checking, :finished, :failed

    event :check do
      transitions from: :created, to: :checking
    end

    event :finish do
      transitions from: :checking, to: :finished
    end

    event :mark_as_failed do
      transitions from: %i[created checking], to: :failed
    end
  end

  def send_failed
    RepositoryCheckMailer.with(check: self).check_failed.deliver_now
  end
end
