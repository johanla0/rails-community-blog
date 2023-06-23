# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  def create
    @post = Post.find(params[:post_id])
    authorize @post, :like?

    if already_liked?
      flash[:notice] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
    else
      @post.post_likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post, :unlike?

    if !already_liked?
      flash[:notice] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
    else
      like = PostLike.likes_for(@post).find_by user_id: current_user.id
      like.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def already_liked?
    @post.liked_by?(current_user)
  end
end
