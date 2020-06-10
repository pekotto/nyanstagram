class UsersController < ApplicationController

  def index
    @posts = current_user.posts.all.order("created_at DESC").page(params[:page]).per(8)
  end

  def show
  	@user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).reverse_order
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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