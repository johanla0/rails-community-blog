# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:john)
    @post_comment = post_comments(:one)

    sign_in @user
  end

  test '#respond' do
    get post_comment_respond_path(@post, @post_comment)

    assert_response :success
  end

  test '#edit' do
    get edit_post_comment_path(@post, @post_comment)

    assert_response :success
  end

  test '#create' do
    attrs = {
      content: 'abc',
      user_id: @user.id
    }
    post post_comments_path(@post), params: { post_comment: attrs }

    assert_response :redirect

    post_comment = PostComment.find_by(attrs)

    assert { post_comment.present? }
  end

  test '#update' do
    attrs = {
      content: 'aaa'
    }
    patch post_comment_path(id: @post_comment.id, post_id: @post.id), params: { post_comment: attrs }

    assert_response :redirect
    @post_comment.reload

    assert { @post_comment.content == attrs[:content] }
  end

  test '#destroy' do
    delete post_comment_path(@post, @post_comment)

    assert_response :success
    post_comment = PostComment.find_by id: @post_comment.id

    assert { post_comment.blank? }
  end
end
