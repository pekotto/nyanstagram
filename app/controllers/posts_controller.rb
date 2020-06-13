class PostsController < ApplicationController
  def index
  	@posts = Post.order("created_at DESC").page(params[:page]).per(8)
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
      tag_list = tag_params[:tag_names].delete(" ").split(",")
      @post.save_tags(tag_list)
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

  def like_posts
    @user = current_user
    @likes = Like.where(user_id: @user.id).order("created_at DESC").page(params[:page]).per(8)
  end

  def following_posts
    @user = current_user
    @users = @user.followings.order("created_at DESC").page(params[:page]).per(8)
  end

  def follower_posts
    @user = current_user
    @users = @user.followers.order("created_at DESC").page(params[:page]).per(8)
  end

  def breeds
    @users = User.where(favorite_breed_id: current_user.favorite_breed.id).where.not(id: current_user.id).page(params[:page]).per(20)
  end

  private

   def post_params
     params.require(:post).permit(:title, :content, :image, :remove_image, :image_cache)
   end

    def tag_params
      params.require(:post).permit(:tag_names)
    end
end
