Rails.application.routes.draw do
  
  namespace :admin do
    resources :users
  end
  root 'tasks#index'
  resources :tasks
  # resources :users
  resources :sessions, only: [:new, :create, :destroy]
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
