# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:john)
    @category = categories(:one)

    sign_in @user
  end

  test '#index' do
    get root_path

    assert_response :success
  end

  test '#new' do
    get new_post_path

    assert_response :success
  end

  test '#create' do
    attrs = {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false),
      category_id: @category.id
    }

    post posts_path, params: { post: attrs }

    assert_response :redirect

    post = Post.find_by(attrs)

    assert { post.present? }
  end

  test '#show' do
    get post_path(@post)

    assert_response :success
  end

  test '#edit' do
    get edit_post_path(@post)

    assert_response :success
  end

  test '#update' do
    attrs = {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false),
    }

    patch post_path(@post), params: { post: attrs }

    assert_response :redirect
    @post.reload

    assert { @post.title == attrs[:title] }
    assert { @post.body == attrs[:body] }
  end

  test '#destroy' do
    delete post_path(@post)

    assert_response :redirect
    post = Post.find_by id: @post.id

    assert { post.blank? }
  end
end
