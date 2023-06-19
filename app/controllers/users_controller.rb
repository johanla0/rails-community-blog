class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users/1 or /users/1.json
  def show
    @posts = @user.posts
  end

  # GET /users/1/edit
  def edit
    authorize current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize current_user

    if @user.update(user_params)
      redirect_to user_path(@user), notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    authorize current_user

    @user.destroy

    redirect_to root_path, notice: I18n.t(".flash.success.#{controller_name}.#{params[:action]}")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :encrypted_password)
  end
end
