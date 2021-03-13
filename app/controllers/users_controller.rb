class UsersController < ApplicationController
  
  def index
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
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
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :gender, :age, :address, :introduction, :average_score)
  end
end
