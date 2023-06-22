# == Schema Information
#
# Table name: post_likes
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class PostLikeTest < ActiveSupport::TestCase
  test 'valid like' do
    like = post_likes(:one)

    assert { like.valid? }
  end

  test 'invalid like without user' do
    like = PostLike.create(
      post: posts(:one)
    )

    assert { like.errors[:user].any? }
  end

  test 'invalid like without post' do
    like = PostLike.create(
      user: users(:john)
    )

    assert { like.errors[:post].any? }
  end
end
