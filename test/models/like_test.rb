# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test 'valid like' do
    like = likes(:one)

    assert { like.valid? }
  end

  test 'invalid like without user' do
    like = Like.create(
      post: posts(:one)
    )

    assert { like.errors[:user].any? }
  end

  test 'invalid like without post' do
    like = Like.create(
      user: users(:john)
    )

    assert { like.errors[:post].any? }
  end
end
