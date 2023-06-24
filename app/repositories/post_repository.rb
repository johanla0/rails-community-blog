# frozen_string_literal: true

module PostRepository
  extend ActiveSupport::Concern

  included do
    scope :with_category, ->(category) { joins(:category).where(category: { id: category.id }) }
    scope :liked_by, ->(user) { joins(:likes).where(likes: { user_id: user.id }) }
    scope :order_by_created_date_desc, -> { order(created_at: :desc) }
    scope :order_by_created_date_asc, -> { order(created_at: :asc) }
  end
end
