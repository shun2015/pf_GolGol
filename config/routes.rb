Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => "homes#about"
  get 'chat/:id' => 'chats#show', as: 'chat'
  get "/rank" => "users#rank"
  devise_for :users
  
  resources :chats, only: [:create]
  resources :users, only: [:index, :show, :edit, :update]do
    resource :relationships, only: [:create, :destroy]
      member do
        get :following, :followers
      end
  end

  resources :posts, only: [:new, :create, :index, :show, :edit,:update, :destroy]do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :notifications, only: :index
end