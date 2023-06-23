# frozen_string_literal: true

class AddCategories < ActiveRecord::Migration[7.0]
  def up
    attributes.each do |attrs|
      Category.where(slug: attrs[:slug]).first_or_create!(attrs)
    end
  end

  def down
    attributes.each do |attrs|
      Category.where(slug: attrs[:slug]).destroy_all
    end
  end

  private

  def attributes
    [
      {
        name: 'General',
        slug: :general
      },
      {
        name: 'UX Design',
        slug: :ux
      },
      {
        name: 'Backend',
        slug: :backend
      }
    ]
  end
end
