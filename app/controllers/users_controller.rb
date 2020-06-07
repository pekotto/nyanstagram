class UsersController < ApplicationController
  def posts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def show
  	@user = current_user
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
	redirect_to user_path(@user)
  end

  def destroy
  	@user = User.find(params[:id])
  end

   private
   def user_params
     params.require(:user).permit(:name, :user_name, :profile_image)
   end
end