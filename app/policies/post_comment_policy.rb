# frozen_string_literal: true

class PostCommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def respond?
    user.present?
  end

  def update?
    user.present? && owner?
  end

  def edit?
    update?
  end

  def destroy?
    user.present?
  end

  private

  def owner?
    record.user == user
  end
end
