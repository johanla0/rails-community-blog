module LikeRepository
  extend ActiveSupport::Concern

  included do
    scope :likes_from, ->(user) { joins(:user).where(user: { id: user.id }) }
    scope :likes_for, ->(post) { joins(:post).where(post: { id: post.id }) }
  end
end
