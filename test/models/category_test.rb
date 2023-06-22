# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  slug       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'valid category' do
    category = Category.create(
      slug: :new,
      name: 'New'
    )

    assert { category.valid? }
  end
end
