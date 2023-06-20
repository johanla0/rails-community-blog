# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  slug       :string           not null
#  name       :string           not null
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

  test 'invalid duplicated category' do
    category = Category.create(
      slug: :basic,
      name: 'New'
    )

    assert { category.errors[:slug].any? }
  end
end
