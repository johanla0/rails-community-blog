# frozen_string_literal: true

module PostRepository
  extend ActiveSupport::Concern

  included do
    scope :with_category, ->(category) { where(category_id: category.id) }
    scope :order_by_created_date_desc, -> { order(created_at: :desc) }
    scope :order_by_created_date_asc, -> { order(created_at: :asc) }
  end
end
