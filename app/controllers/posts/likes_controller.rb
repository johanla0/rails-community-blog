# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  def create
    @post = Post.find(params[:post_id])
    authorize @post, :like?

    if already_liked?
      flash[:notice] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post, :unlike?

    if already_liked?
      like = PostLike.find_by(post: @post, user: current_user)
      like.destroy
    else
      flash[:notice] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
    end
    redirect_to post_path(@post)
  end

  private

  def already_liked?
    @post.likes.exists?(user: current_user)
  end
end
