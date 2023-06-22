module PostRepository
  extend ActiveSupport::Concern

  included do
    scope :with_category, ->(category) { joins(:category).where(category: { id: category.id }) }
    scope :liked_by, ->(user) { joins(:post_likes).where(post_likes: { user_id: user.id }) }
  end
end
