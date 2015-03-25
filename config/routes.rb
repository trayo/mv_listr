Rails.application.routes.draw do
  root "home#index"

  resources :sessions, only: [:create]
  resources :recommendations, only: [:create, :update, :destroy]

  get "/recommendations",
      to: "recommendations#index",
      watched_status: false

  get "/recommendations/watched",
      to: "recommendations#index",
      watched_status: true

  resources :twilio, only: [:create]

  delete "/logout", to: "sessions#destroy"

  get "/auth/twitter"
  get "/auth/:provider/callback", to: "sessions#create"
end
