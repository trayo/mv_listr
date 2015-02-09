Rails.application.routes.draw do
  root 'home#index'

  resources :sessions, only: [:create]
  resources :recommendations, only: [:index,  :create, :update, :destroy]

  resources :watched_recommendations, only: [:destroy]

  resources :twilio, only: [:create]

  get '/recommendations/watched', to: 'watched_recommendations#index'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/twitter'
  get '/auth/:provider/callback', to: 'sessions#create'
end
