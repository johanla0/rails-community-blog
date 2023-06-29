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
  include Presentable

  belongs_to :creator, class_name: 'User'
  alias_attribute :user, :creator

  belongs_to :category
  has_many :likes, class_name: 'PostLike', dependent: :destroy
  has_many :comments, class_name: 'PostComment', dependent: :destroy

  validates :title, presence: true
  validates :body, length: { minimum: 10 }

  include PostRepository

  def liked_by?(user)
    likes.exists?(user:)
  end
end
