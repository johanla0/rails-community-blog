class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
