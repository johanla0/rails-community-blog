class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    authorize @post, :like?

    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post, :unlike?

    if !already_liked?
      flash[:notice] = "Cannot unlike"
    else
      like = Like.likes_for(@post).find_by user_id: current_user.id
      like.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def already_liked?
    likes_from_user = Like.likes_from(current_user)
    likes_for_post = Like.likes_for(@post)
    likes_from_user.merge(likes_for_post).present?
  end
end
