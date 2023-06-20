module PostRepository
  extend ActiveSupport::Concern

  included do
    scope :with_category, ->(category) { joins(:category).where(category: { id: category.id }) }
  end
end
