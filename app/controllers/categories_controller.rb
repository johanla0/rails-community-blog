class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = Post.with_category(@category)
  end
end
