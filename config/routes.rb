Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations"
    }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"

  # User-related
  resources :users

  get "/users/follow/:user_id" => "users#follow"
  get "/users/unfollow/:user_id" => "users#unfollow"

  # Post-related
  resources :posts, only: [ :show, :create, :new ]
  get "/likings/like/:post_id" => "likings#like"
  get "/likings/unlike/:post_id" => "likings#unlike"

  # Comment-related
  resources :comments, only: [ :create ]
  resources :profiles, only: [ :edit, :show, :update ]
end
