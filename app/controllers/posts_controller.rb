# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all.order_by_created_date_desc.includes(%i[category creator]).map(&:decorate)
  end

  def show
    @post = Post.find(params[:id]).decorate
    @comments = PostComment.roots.where(post: @post).includes(%i[post user])
    @comment = PostComment.new
  end

  def new
    authorize Post

    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id]).decorate
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.save
      redirect_to post_path(@post), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id]).decorate
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id]).decorate
    authorize @post

    @post.destroy

    redirect_to root_path, notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
