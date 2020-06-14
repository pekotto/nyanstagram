class Admin::UsersController < ApplicationController

  def index
	@users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.all.find(params[:id])
    @posts = Post.where(user_id: @user.id).reverse_order
  end

  def edit
    @user = User.all.find(params[:id])
  end

  def update
    @user = User.all.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end

  def destroy
    @user = User.all.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :user_name, :email)
  end
end
