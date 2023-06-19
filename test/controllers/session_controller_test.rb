require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
  end

  test '#create' do
    attrs = {
      email: @user.email,
      password: 'password'
    }

    post user_session_path, params: { user: attrs }

    assert_response :redirect
  end

  test '#create fails with wrong password ' do
    attrs = {
      email: @user.email,
      password: 'wrong_password'
    }

    post user_session_path, params: { user: attrs }

    assert_response :unprocessable_entity
  end

  test '#create fails with unknown user' do
    attrs = {
      email: 'unknown@user.email',
      password: 'password'
    }

    post user_session_path, params: { user: attrs }

    assert_response :unprocessable_entity
  end
end
