Rails.application.routes.draw do
  root 'home#index'

  resources :sessions, only: [:create]
  resources :recommendations

  get '/auth/:provider/callback', to: 'sessions#create'
end
