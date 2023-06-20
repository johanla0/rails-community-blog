class SetDefaultCategoryForPosts < ActiveRecord::Migration[7.0]
  def up
    category = Category.find_by slug: :general
    Post.where(category: nil).update_all(category_id: category.id)
  end

  def down; end
end
