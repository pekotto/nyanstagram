class UsersController < ApplicationController

  def index
    @posts = current_user.posts.all
  end

  def show
  	@user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).reverse_order
  end

  def following
      @user = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

   private
   def user_params
     params.require(:user).permit(:name, :user_name, :profile_image)
   end
end