# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :photos
    resources :pois
    resources :regions
    resources :tracks
    resources :zones
    root to: 'regions#index'
  end

  namespace :api, defaults: { format: :json } do
    resources :pois, only: [:show]
    resources :tracks, only: [:show]
    resources :zones, only: [:show]
  end

  resources :pois, only: [:show], path: 'pdi'
  resources :tracks, only: [:show], path: 'traseu'
  resources :zones, only: [:show], path: 'unde'

  get 'pages/home'
  get 'pages/no_zone'
  root 'pages#home'

  # devise
  devise_for :users

  # sidekiq
  authenticate :user, ->(user) { user.admin? } do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
