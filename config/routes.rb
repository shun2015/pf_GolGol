Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/show'
  get 'users/show'
  root to: 'homes#top'
  get '/about' => "homes#about"
  devise_for :users
  resources :users, only: [:show,:edit,:update]
  resources :posts, only: [:new, :create, :index, :show, :destroy]do
    resources :post_comments, only: [:create, :destroy]
  end
end
