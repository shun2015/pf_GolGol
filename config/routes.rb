Rails.application.routes.draw do
  get 'users/show'
  root to: 'homes#top'
  get '/about' => "homes#about"
  devise_for :users
  resources :users, only: [:show,:edit,:update]
end
