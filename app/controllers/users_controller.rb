# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]).decorate
    @posts = @user.posts.map(&:decorate)
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      redirect_to user_path(@user), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user

    @user.destroy

    redirect_to root_path, notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
