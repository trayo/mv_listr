Rails.application.routes.draw do
  root 'home#index'

  resources :sessions, only: [:create]
  resources :recommendations

  delete '/logout', to: 'sessions#destroy'

  get '/auth/twitter'

  get '/auth/:provider/callback', to: 'sessions#create'
end
