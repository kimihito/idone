Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  resources :users, only: [:index]
  mount PgHero::Engine, at: "pghero"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
