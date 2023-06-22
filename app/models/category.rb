# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  slug       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :posts, dependent: :nullify
end
