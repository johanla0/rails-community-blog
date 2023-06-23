# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  creator_id  :integer
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
end
