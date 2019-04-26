Rails.application.routes.draw do
  namespace :admin do
    resources :regions
    resources :zones
    resources :pois
    root to: "regions#index"
  end

  namespace :api, defaults: { format: :json } do
    resources :zones, only: [:show]
    resources :pois, only: [:show]
  end

  resources :zones, only: [:show], path: 'unde'
  resources :pois, only: [:show], path: 'pdi'

  get 'pages/home'
  root 'pages#home'

  # devise
  devise_for :users

  # sidekiq
  authenticate :user, lambda { |user| user.admin? } do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
