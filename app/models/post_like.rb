# frozen_string_literal: true

# == Schema Information
#
# Table name: post_likes
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user

  include PostLikeRepository
end
