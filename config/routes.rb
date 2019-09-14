Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  resources :users, param: :name, only: %w[index show edit update] do
    resources :projects, only: %w[index]. module: 'users'
  end

  resources :tracks

  resources :projects, only: [:index, :new, :create, :edit, :update, :destroy] do
    with_options module: 'projects' do
      resources :tracks, only: [:index]
      resources :members, only: [:index]
      resource :stats, only: [:show]
    end
  end

  get 'projects/:id', to: redirect("/projects/%{id}/tracks")

  authenticated :user do
    namespace :my do
      resources :projects, only: :index, default: { format: :json }
    end

    namespace :root do
      resources :tracks, only: [:create]
    end
  end


  mount PgHero::Engine, at: "pghero"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
