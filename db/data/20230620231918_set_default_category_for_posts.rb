# frozen_string_literal: true

class SetDefaultCategoryForPosts < ActiveRecord::Migration[7.0]
  def up
    category = Category.find_by slug: :general
    Post.where(category: nil).each { |p| p.update(category_id: category.id) }
  end

  def down; end
end
