require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test '#new' do
    get new_user_registration_path

    assert_response :success
  end

  test '#create' do
    assert_difference('User.count') do
      post user_registration_path, params: {
        user: {
          email: 'john@new.com',
          first_name: 'John',
          last_name: 'Smith',
          password: 'password'
        }
      }
    end

    assert_redirected_to root_path
  end

  test '#create fails without email' do
    post user_registration_path, params: {
      user: {
        first_name: 'John',
        last_name: 'Smith',
        password: 'password'
      }
    }

    assert_response :unprocessable_entity
  end
end
