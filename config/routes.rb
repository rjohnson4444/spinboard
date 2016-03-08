Rails.application.routes.draw do
  root to: 'home#home'

  get '/home', to: 'home#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :links, only: [:index]
end
