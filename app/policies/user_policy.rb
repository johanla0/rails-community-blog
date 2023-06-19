class UserPolicy < ApplicationPolicy
  def edit?
    user.present? && self?
  end

  alias update? edit?
  alias destroy? edit?

  private

  def self?
    record == user
  end
end
