Rails.application.routes.draw do
  devise_for :users
  root to: 'reserves#index'
  resources :reserves, only: [:new, :create]
  resources :visuals
  resources :blogs do
    resources :blog_comments, only: :create
  end
  resources :chats, only: [:new, :create]
  resources :messages, only: [:index, :create]
  resources :foods do
    resources :food_comments, only: :create
  end
  resources :drinks do
    resources :drink_comments, only: :create
  end
end
