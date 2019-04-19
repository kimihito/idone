Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  resources :users, only: [:index]
  resources :contributions

  resources :projects do
    resource :done, only: [:show], module: 'projects'
    resource :stats, only: [:show], module: 'projects'
    resources :contributions, only: [:index, :new, :create], module: 'projects'
  end

  authenticated :user do
    resources :contributions, only: [:new, :create]
    namespace :my do
      resources :projects, only: :index, default: { format: :json }
    end
  end

  mount PgHero::Engine, at: "pghero"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
