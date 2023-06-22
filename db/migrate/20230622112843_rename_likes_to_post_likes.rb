class RenameLikesToPostLikes < ActiveRecord::Migration[7.0]
  def change
    rename_table :likes, :post_likes
  end
end
