# frozen_string_literal: true

class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = Post.with_category(@category).map(&:decorate)
  end
end
