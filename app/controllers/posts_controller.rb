class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id
    # 投稿するごとにレベルが上がる
    @user.exp_sum += @post.exp.to_i
    if @user.level == 1
      @user.level += @user.exp_sum.to_i
    else
      @user.level = @user.exp_sum.to_i + 1
    end
    current_user.update(exp_sum: @user.exp_sum, level: @user.level)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @q = Post.ransack(params[:q])
    @post_s = @q.result(distinct: true).page(params[:page]).per(9)
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
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
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
    params.require(:post).permit(:title, :date, :score, :impression, :exp, post_images_images: [])
  end

end