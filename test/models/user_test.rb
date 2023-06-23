# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = users(:john)

    assert { user.valid? }
  end

  test 'invalid user without email' do
    user = User.create(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password'
    )

    assert { user.errors[:email].any? }
  end

  test 'invalid user without password' do
    user = User.create(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@test.com'
    )

    assert { user.errors[:password].any? }
  end
end
