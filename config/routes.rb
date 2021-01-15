Rails.application.routes.draw do
  
  namespace :admin do
    get 'users/new'
    get 'users/edit'
    get 'users/show'
    get 'users/index'
  end
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
