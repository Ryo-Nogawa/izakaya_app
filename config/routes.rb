Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
    get 'users/sign_up/complete', to: 'users/registrations#complete'
  end
  root to: 'books#index'
  resources :books, only: [:new, :create, :edit, :update, :destroy] do
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
  resources :visuals
  resources :blogs do
    resources :blog_comments, only: :create
    resource :blog_likes, only: [:create, :destroy]
  end
  resources :rooms, only: [:new, :create]
  resources :messages, only: [:index, :create]
  resources :foods do
    resources :food_comments, only: :create
    resource :food_likes, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  resources :drinks do
    resources :drink_comments, only: :create
    resource :drink_likes, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  resources :users, only: :show
end
