class UsersController < ApplicationController

  def index
    @q = User.ransack(params[:q])
    @user_s = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
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
    @user_avg = User.all.joins(:posts).group(:id).select("AVG(posts.score) as average_score, users.*").order("average_score asc")
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :gender, :age, :address, :introduction, :profile_score)
  end
end
