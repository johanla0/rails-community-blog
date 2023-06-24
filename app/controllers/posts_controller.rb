# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order_by_created_date_desc
  end

  def show
    @comments = PostComment.root_comments_for(@post)
    @comment = PostComment.new
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params.merge(creator_id: current_user.id))
    authorize @post

    if @post.save
      redirect_to post_path(@post), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post

    @post.destroy

    redirect_to root_path, notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
