Rails.application.routes.draw do
  devise_for :users
  root to: 'reserves#index'
end
