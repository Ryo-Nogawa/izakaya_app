Rails.application.routes.draw do
  devise_for :users
  root to: 'reserves#index'
  resources :reserves, only: [:new, :create]
  resources :visuals
  resources :blogs
  resources :chats, only: [:new, :create]
  resources :messages, only: [:index, :create]

end
