class PostsController < ApplicationController
  def index
  	@posts = Post.page(params[:page]).reverse_order
  end

  def new
  	@post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
        redirect_to post_path(@post)
    else
        render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path
  end

  def likes
    @user = current_user
    @likes = Like.where(user_id: @user.id)
  end

  def following_posts
    @user = current_user
    @users = @user.followings.order("created_at DESC").page(params[:page]).per(20)
  end

  private

   def post_params
     params.require(:post).permit(:title, :content, :image)
   end
end
