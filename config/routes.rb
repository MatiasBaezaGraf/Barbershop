Rails.application.routes.draw do
  get 'users/index'
  match '/users',   to: 'users#index',   via: 'get'
  devise_for :users
  resources :turns
  resources :services
  resources :barbers
  root to: 'pages#home'
  delete "/users/:id" => "users#destroy", as: :user
  match '/users/:id',     to: 'users#show',       via: 'get'
  get '/stylists' => 'pages#stylists'
  get '/home' => 'pages#home'
  get '/select' => 'pages#select'
  get '/edit2' => 'turns#edit2'
  get '/edit0' => 'turns#edit0'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
