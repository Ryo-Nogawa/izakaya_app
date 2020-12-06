Rails.application.routes.draw do
  devise_for :users
  root to: 'reserves#index'
  resources :reserves, only: [:new, :create, :edit, :update, :destroy]
  resources :visuals
  resources :blogs do
    resources :blog_comments, only: :create
  end
  resources :chats, only: [:new, :create]
  resources :messages, only: [:index, :create]
  resources :foods do
    resources :food_comments, only: :create
  end
  post 'foods/:id', to: 'food_likes#create', as: 'create_food_like'
  delete 'foods/:id', to: 'food_likes#destroy', as: 'destroy_food_like'
  resources :drinks do
    resources :drink_comments, only: :create
  end
  resources :users, only: :show
end
