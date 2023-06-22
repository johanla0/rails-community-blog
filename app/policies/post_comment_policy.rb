class PostCommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  alias respond? create?

  def edit?
    user.present? && owner?
  end

  alias update? edit?
  alias destroy? edit?

  private

  def owner?
    record.user == user
  end
end
