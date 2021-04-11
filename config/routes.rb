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
    resources :users, only: [:show]
    resources :posts, only: [:index, :create, :show, :update, :destroy]
    resources :likes, only: [:index, :create, :destroy]
    resources :profiles, only: [:show, :update]
    resources :comments, only: [:create, :show, :update, :destroy]
    resources :friendships, only: [:create, :show, :update, :destroy]
  end
end
