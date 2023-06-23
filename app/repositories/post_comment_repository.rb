# frozen_string_literal: true

module PostCommentRepository
  extend ActiveSupport::Concern

  included do
    scope :root_comments_for, ->(post) { joins(:post).where(post: { id: post.id }).where(ancestry: nil) }
  end
end
