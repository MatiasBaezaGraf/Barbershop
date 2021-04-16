Rails.application.routes.draw do
  get 'users/index'
  match '/users',   to: 'users#index',   via: 'get'
  devise_for :users
  resources :turns
  resources :services
  resources :barbers
  root to: "barbers#index"
  delete "/users/:id" => "users#destroy", as: :user
  match '/users/:id',     to: 'users#show',       via: 'get'
  resources :users, :only =>[:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
