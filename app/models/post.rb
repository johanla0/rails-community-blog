# frozen_string_literal: true

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
class Post < ApplicationRecord
  include PostPresenter

  belongs_to :creator, class_name: 'User', optional: true, foreign_key: 'creator_id'
  alias_attribute :user, :creator

  belongs_to :category, optional: true
  has_many :post_likes, dependent: :destroy
  alias_attribute :likes, :post_likes

  has_many :post_comments, dependent: :destroy
  alias_attribute :comments, :post_comments

  validates :title, presence: true
  validates :body, length: { minimum: 10 }

  include PostRepository

  def liked_by?(user)
    Post.liked_by(user).include? self
  end
end
