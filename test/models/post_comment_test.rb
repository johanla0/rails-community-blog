# == Schema Information
#
# Table name: post_comments
#
#  id         :integer          not null, primary key
#  content    :text
#  post_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string
#
require 'test_helper'

class PostCommentTest < ActiveSupport::TestCase
  test 'valid post_comment' do
    post_comment = post_comments(:one)

    assert { post_comment.valid? }
  end

  test 'invalid post_comment without user' do
    post_comment = PostComment.create(
      user: users(:john)
    )

    assert { post_comment.errors[:post].any? }
  end
end
