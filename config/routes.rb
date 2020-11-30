Rails.application.routes.draw do
  devise_for :users
  root to: 'reserves#index'
  resources :reserves, only: [:new, :create]
  resources :visuals, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  resources :chats, only: [:index, :new]
end
