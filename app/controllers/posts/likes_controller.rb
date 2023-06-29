# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  def create
    authorize Post, :like?

    @post = resource_post
    if @post.liked_by?(current_user)
      flash[:notice] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    authorize Post, :unlike?
    @post = resource_post

    if @post.liked_by?(current_user)
      like = PostLike.find_by(post: @post, user: current_user)
      like.destroy
    else
      flash[:notice] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
    end
    redirect_to post_path(@post)
  end
end
