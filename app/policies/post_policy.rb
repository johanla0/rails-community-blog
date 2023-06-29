# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && owner?
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && owner?
  end

  def like?
    user.present?
  end

  def unlike?
    like?
  end

  private

  def owner?
    record.user == user
  end
end
