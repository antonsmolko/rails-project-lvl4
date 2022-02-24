# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def show?
    owner?
  end
end
