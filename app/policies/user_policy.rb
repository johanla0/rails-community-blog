# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def update?
    user.present? && self?
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && self?
  end

  private

  def self?
    record == user
  end
end
