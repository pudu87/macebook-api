Rails.application.routes.draw do
  # devise_for :users, only: [:sessions], controllers: {sessions: 'users/sessions'}

  namespace :api, constraints: { format: 'json' } do
    resources :users, only: [:index, :show]
    resources :posts, only: [:index, :create, :update, :destroy]
    resources :likes, only: [:index, :create, :destroy]
    resources :profiles, only: [:show, :update]
    resources :comments, only: [:index, :create, :update, :destroy]
    resources :friendships, only: [:create, :update, :destroy]
  end  
end
