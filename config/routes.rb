Rails.application.routes.draw do
  devise_for :users, 
    path: 'api', 
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'api/sessions',
      registrations: 'api/registrations'
    }

  namespace :api, constraints: { format: 'json' } do
    resources :users, only: [:index, :show]
    resources :posts, only: [:index, :create, :update, :destroy]
    resources :likes, only: [:index, :create, :destroy]
    resources :profiles, only: [:show, :update]
    resources :comments, only: [:create, :show, :update, :destroy]
    resources :friendships, only: [:create, :update, :destroy]
  end
end
