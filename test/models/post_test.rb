# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'valid post' do
    post = posts(:one)

    assert { post.valid? }
  end

  test 'invalid post without user' do
    post = Post.create(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false)
    )

    assert { post.errors[:user].any? }
  end

  test 'invalid post without category' do
    post = Post.create(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false),
      user_id: users(:john).id
    )

    assert { post.errors[:category].any? }
  end
end
