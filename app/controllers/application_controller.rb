class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top] #ログインしていないユーザーはtop画面のみ閲覧可能
  
  #新規登録後の遷移先
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :age, :address, :gender, :profile_score, :introduction])
  end
end
