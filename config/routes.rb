Rails.application.routes.draw do
  namespace :admin do
      resources :regions
      resources :zones
      root to: "regions#index"
    end
  get 'pages/home'
  root 'pages#home'
end
