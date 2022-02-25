# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def create?
    owner?
  end

  def show?
    owner?
  end

  private

  def owner?
    @record.repository.user == @user
  end
end
