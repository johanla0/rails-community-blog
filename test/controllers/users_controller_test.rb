# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)

    @user_session = sign_in @user
  end

  test '#show' do
    get user_path(@user)

    assert_response :success
  end

  test '#edit' do
    @user_session.get @user_session.edit_user_path(@user)

    @user_session.assert_response :success
  end

  test '#update' do
    @user_session.patch @user_session.user_path(@user), params: { user: { email: @user.email, first_name: 'Jim', last_name: 'Smith' } }

    @user_session.assert_response :redirect
  end

  test '#destroy' do
    @user_session.delete @user_session.user_path(@user)

    @user_session.assert_response :redirect
    user = User.find_by id: @user.id

    assert { user.blank? }
  end
end
