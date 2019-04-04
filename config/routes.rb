Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  resources :users, only: [:index]
  resources :actions, only: [:index]

  resources :projects do
    resource :done, only: [:show], module: 'projects'
    resource :stats, only: [:show], module: 'projects'
    resources :actions, only: [:index, :new, :create], module: 'projects'
  end

  mount PgHero::Engine, at: "pghero"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
