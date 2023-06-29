# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:no_likes)
    @user = users(:john)

    sign_in @user
  end

  test '#create' do
    previous_like = PostLike.last

    post post_likes_path(@post)

    assert_response :redirect

    new_like = PostLike.last

    assert { new_like.present? }
    assert { new_like != previous_like }
    assert { new_like.user == @user }
    assert { new_like.post == @post }
  end

  test '#destroy' do
    like = post_likes(:one)

    delete post_like_path(@post.id, id: like.id)

    assert_response :redirect

    assert { PostLike.where(id: like.id).blank? }
  end
end
