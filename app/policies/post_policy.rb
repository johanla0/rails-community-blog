class PostPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  alias create? new?

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
