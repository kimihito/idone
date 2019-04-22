Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  resources :users, only: [:index]
  resources :contributions
  resources :tracks

  resources :projects do
    with_options module: 'projects' do
      resources :tracks, only: [:index]
      resources :members, only: [:index]
      resource :stats, only: [:show]
    end
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
