# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'valid post' do
    post = posts(:one)

    assert_predicate(post, :valid?)
  end

  test 'invalid without user' do
    post = Post.create(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false)
    )

    assert_not_empty post.errors[:user]
  end
end
