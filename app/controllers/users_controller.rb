class UsersController < ApplicationController

  def index
    @q = User.ransack(params[:q])
    @user_s = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    # フォロワーの投稿表示
    @users = @user.following
    @follow_post = []
    if @users.present?
      @users.each do |user|
        post_s = Post.where(user_id: user.id).order(created_at: :desc)
        #取得したユーザーの投稿一覧を@postsに格納
        @follow_post.concat(post_s)
      end
      #@postsを新しい順に並べる
      @follow_post.sort_by!{|post| post.created_at}
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to root_path
  end

  def following
     @user = User.find(params[:id])
     @users = @user.following.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  def rank
    @user_avg = User.joins(:posts).group(:id).select("AVG(posts.score) as average_score, users.*").order("average_score asc").limit(10)
    end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :gender, :age, :address, :introduction, :profile_score)
  end
end
