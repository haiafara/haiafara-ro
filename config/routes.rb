Rails.application.routes.draw do
  namespace :admin do
    resources :regions
    resources :zones
    root to: "regions#index"
  end
  namespace :api, defaults: { format: :json } do
    resources :zones, only: [:show]
  end
  resources :zones, only: [:show], path: 'unde'
  get 'pages/home'
  root 'pages#home'
end
