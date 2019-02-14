Rails.application.routes.draw do
  namespace :admin do
    resources :regions
    resources :zones
    resources :pois
    root to: "regions#index"
  end
  namespace :api, defaults: { format: :json } do
    resources :zones, only: [:show]
  end
  resources :zones, only: [:show], path: 'unde'
  resources :pois, only: [:show], path: 'poi'
  get 'pages/home'
  root 'pages#home'
end
