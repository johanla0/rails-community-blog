require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:john)
    @post_comment = post_comments(:one)

    @user_session = sign_in @user
  end

  test '#respond' do
    @user_session.get @user_session.post_comment_respond_path(@post, @post_comment)

    @user_session.assert_response :success
  end

  test '#edit' do
    @user_session.get @user_session.edit_post_comment_path(@post, @post_comment)

    @user_session.assert_response :success
  end

  test '#create' do
    attrs = {
      content: 'abc',
      user_id: @user.id
    }
    @user_session.post @user_session.post_comments_path(@post), params: { post_comment: attrs }

    @user_session.assert_response :ok

    post_comment = PostComment.find_by(attrs)

    assert { post_comment.present? }
  end

  test '#update' do
    @user_session.patch @user_session.post_comment_path(id: @post_comment.id, post_id: @post.id), params: { post_comment: { content: 'aaa' } }

    @user_session.assert_response :success
  end

  test '#destroy' do
    @user_session.delete @user_session.post_comment_path(@post, @post_comment)

    @user_session.assert_response :success
    post_comment = PostComment.find_by id: @post_comment.id

    assert { post_comment.blank? }
  end
end
