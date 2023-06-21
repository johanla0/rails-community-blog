require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:john)

    @user_session = sign_in @user
  end

  test '#create' do
    @user_session.post @user_session.post_likes_path(@post)

    @user_session.assert_response :redirect

    like = Like.last

    assert { like.present? }
    assert { like.user == @user }
    assert { like.post == @post }
  end

  test '#destroy' do
    like = likes(:one)
    likes_before = @post.likes.count

    @user_session.delete @user_session.post_like_path(@post.id, id: like.id)

    @user_session.assert_response :redirect

    @post.reload
    likes_after = @post.likes.count

    assert { likes_after < likes_before }
  end
end
