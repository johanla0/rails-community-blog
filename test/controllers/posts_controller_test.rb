# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:john)
    @category = categories(:one)

    @user_session = sign_in @user
  end

  test '#index' do
    get root_path

    assert_response :success
  end

  test '#new' do
    @user_session.get @user_session.new_post_path

    @user_session.assert_response :success
  end

  test '#create' do
    attrs = {
      body: @post.body,
      title: @post.title,
      creator_id: @user.id,
      category_id: @category.id
    }

    @user_session.post @user_session.posts_path, params: { post: attrs }

    @user_session.assert_response :redirect

    post = Post.find_by(attrs)

    assert { post.present? }
  end

  test '#create without creator' do
    attrs = {
      body: @post.body,
      title: @post.title,
      category_id: @category.id
    }

    @user_session.post @user_session.posts_path, params: { post: attrs }

    @user_session.assert_response :redirect

    post = Post.find_by(attrs)

    assert { post.present? }
  end

  test '#show' do
    get post_path(@post)

    assert_response :success
  end

  test '#edit' do
    @user_session.get @user_session.edit_post_path(@post)

    @user_session.assert_response :success
  end

  test '#update' do
    @user_session.patch @user_session.post_path(@post), params: { post: { body: @post.body, title: @post.title } }

    @user_session.assert_response :redirect
  end

  test '#destroy' do
    @user_session.delete @user_session.post_path(@post)

    @user_session.assert_response :redirect
    post = Post.find_by id: @post.id

    assert { post.blank? }
  end
end
