Rails.application.routes.draw do
  root to: 'home#home'

  get '/home', to: 'home#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:index, :create, :update]
    end
  end
end
