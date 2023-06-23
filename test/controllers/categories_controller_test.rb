# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    @category = categories(:one)
    get category_path(@category)

    assert_response :success
  end
end
