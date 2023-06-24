# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comments
#
#  id         :integer          not null, primary key
#  content    :text
#  post_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string
#
class PostComment < ApplicationRecord
  include PostCommentPresenter

  belongs_to :post
  belongs_to :user, optional: true

  has_ancestry orphan_strategy: :destroy

  include PostCommentRepository
end
