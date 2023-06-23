# frozen_string_literal: true

module PostRepository
  extend ActiveSupport::Concern

  included do
    scope :with_category, ->(category) { joins(:category).where(category: { id: category.id }) }
    scope :liked_by, ->(user) { joins(:likes).where(likes: { user_id: user.id }) }
  end
end
