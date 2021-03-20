class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def index
    @posts = Post.all
    @q = Post.ransack(params[:q])
    @post_s = @q.result(distinct: true)
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end
  
  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to post_path
    end
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :date, :score, :impression, post_images_images: [])
  end
  
end