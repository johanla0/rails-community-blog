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
class Post < ApplicationRecord
  include PostPresenter

  belongs_to :creator, class_name: 'User'
  alias_attribute :user, :creator

  # belongs_to :user, foreign_key: 'creator_id', inverse_of: :posts
  # alias_attribute :creator, :user

  belongs_to :category
  has_many :post_likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, length: { minimum: 10 }

  include PostRepository

  def liked_by?(user)
    Post.liked_by(user).include? self
  end
end
