# frozen_string_literal: true

Rails.application.routes.draw do
  # divice
  devise_for :users, controllers: {
    # omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
    get 'users/sign_up/complete', to: 'users/registrations#complete'
  end
  # rootパス
  root to: 'books#index'
  # books
  resources :books, only: %i[new create edit update destroy] do
    collection do
      post :confirm
      get :complete
      get :edit_complete
      post :new, path: :new, as: :new, action: :back
    end
    namespace :admin do
      resources :books, only: :index
    end
  end
  # visuals
  resources :visuals do
    collection do
      get :search
    end
  end
  #blogs
  resources :blogs do
    resources :blog_comments, only: :create
    resource :blog_likes, only: %i[create destroy]
  end
  # rooms
  resources :rooms, only: %i[new create]
  # messages
  resources :messages, only: %i[index create destroy]
  # foods
  resources :foods do
    resources :food_comments, only: :create
    resource :food_likes, only: %i[create destroy]
    collection do
      get :search
    end
  end
  # drinks
  resources :drinks do
    resources :drink_comments, only: :create
    resource :drink_likes, only: %i[create destroy]
    collection do
      get :search
    end
  end
  # users
  resources :users, only: :show
end
