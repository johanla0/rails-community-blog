require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test 'should get index' do
    get root_path

    assert_response :success
  end

  test 'should get new' do
    get new_post_path

    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_path, params: { post: { body: @post.body, title: @post.title, user_id: users(:john).id } }
    end

    assert_redirected_to post_path(Post.last)
  end

  test 'should show post' do
    get post_path(@post)

    assert_response :success
  end

  test 'should get edit' do
    get edit_post_path(@post)

    assert_response :success
  end

  test 'should update post' do
    patch post_path(@post), params: { post: { body: @post.body, title: @post.title } }

    assert_redirected_to post_path(@post)
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_path(@post)
    end

    assert_redirected_to root_path
  end
end
