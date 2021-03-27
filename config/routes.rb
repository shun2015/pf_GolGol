Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get 'chat/:id' => 'chats#show', as: 'chat'
  get "/rank" => "users#rank"
  get "/withdrawal" => "users#destroy"

  resources :users, only: [:index, :show, :edit, :update, :destroy]do
    resource :relationships, only: [:create, :destroy]
      member do
        get :following, :followers
      end
  end
  resources :posts, only: [:new, :create, :index, :show, :edit,:update, :destroy]do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :chats, only: [:create]
  resources :notifications, only: [:index, :destroy]
end