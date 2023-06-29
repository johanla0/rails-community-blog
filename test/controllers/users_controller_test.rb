# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)

    sign_in @user
  end

  test '#show' do
    get user_path(@user)

    assert_response :success
  end

  test '#edit' do
    get edit_user_path(@user)

    assert_response :success
  end

  test '#update' do
    attrs = {
      email: @user.email,
      first_name: 'Jim',
      last_name: 'Smith'
    }
    patch user_path(@user), params: { user: attrs }

    assert_response :redirect
    @user.reload

    assert { @user.first_name == attrs[:first_name] }
    assert { @user.last_name == attrs[:last_name] }
  end

  test '#destroy' do
    delete user_path(@user)

    assert_response :redirect
    user = User.find_by id: @user.id

    assert { user.blank? }
  end
end
