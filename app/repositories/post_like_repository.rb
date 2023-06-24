# frozen_string_literal: true

module PostLikeRepository
  extend ActiveSupport::Concern

  included do
    scope :likes_for, ->(post) { joins(:post).where(post: { id: post.id }) }
  end
end
