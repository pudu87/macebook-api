Rails.application.routes.draw do
  devise_for :users

  namespace :api, constraints: { format: 'json' } do
    resources :users
  end  
end
