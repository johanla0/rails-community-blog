# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  before_action :set_post, only: %i[respond create update destroy]

  def respond
    @comment = PostComment.new
    authorize @comment

    @parent_comment = PostComment.find(params[:comment_id])
  end

  def edit
    @comment = PostComment.find(params[:id])
    authorize @comment
  end

  def create
    @comment = PostComment.new(comment_params.merge(post_id: params[:post_id], user_id: current_user.id))
    authorize @comment

    if @comment.save
      flash[:success] = I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
      render turbo_stream: [
        turbo_stream.replace(
          helpers.dom_id(@post, :comments),
          partial: 'posts/comments',
          locals: { comment: @comment, comments: PostComment.root_comments_for(@post), post: @post }
        ),
        turbo_stream.replace(
          'form',
          partial: 'posts/comments/shared/form',
          locals: { comment: PostComment.new, url: post_comments_path(@post), turbo_method: :post }
        ),
        turbo_stream.update(
          'flash',
          partial: 'layouts/shared/flash'
        )
      ], status: :found
    else
      flash[:error] = I18n.t(".flash.error.#{controller_name}.#{params[:action]}")
      redirect_back fallback_location: post_path(@post), status: :unprocessable_entity
    end
  end

  def update
    comment = PostComment.find(params[:id])
    authorize comment

    if comment.update(comment_params)
      flash[:success] = I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
      render turbo_stream: [
        turbo_stream.replace(
          helpers.dom_id(@post, :comments),
          partial: 'posts/comments',
          locals: { comment:, comments: PostComment.root_comments_for(@post), post: @post }
        ),
        turbo_stream.replace(
          'form',
          partial: 'posts/comments/shared/form',
          locals: { comment: PostComment.new, url: post_comments_path(@post), turbo_method: :post }
        ),
        turbo_stream.update(
          'flash',
          partial: 'layouts/shared/flash'
        )
      ], status: :found
    else
      redirect_back fallback_location: post_path(@post), status: :unprocessable_entity
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    authorize comment

    comment.destroy

    flash[:success] = I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    render turbo_stream: [
      turbo_stream.replace(
        helpers.dom_id(@post, :comments),
        partial: 'posts/comments',
        locals: { comment:, comments: PostComment.root_comments_for(@post), post: @post }
      ),
      turbo_stream.replace(
        'form',
        partial: 'posts/comments/shared/form',
        locals: { comment: PostComment.new, url: post_comments_path(@post), turbo_method: :post }
      ),
      turbo_stream.update(
        'flash',
        partial: 'layouts/shared/flash'
      )
    ], status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
