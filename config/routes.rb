Rails.application.routes.draw do
  devise_scope :user do
    namespace :users do
      resource :security, only: %w[edit update]
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }

  root 'root#index'

  authenticated :user do
    namespace :my do
      resources :tags, only: :index, default: { format: :json }
      resources :projects, only: :index, default: { format: :json }
    end

    namespace :root do
      resources :tracks, only: [:create]
    end

    resource :user_option, only: %w[edit update]
  end

  resources :tracks

  resources :projects, only: %w[index new create edit update destroy] do
    with_options module: 'projects' do
      resources :tracks, only: [:index]
      resource :members, only: [:show, :edit, :update]
      resource :stats, only: [:show]
    end
  end

  get 'projects/:id', to: redirect("/projects/%{id}/tracks")

  resources :users, param: :name, only: %w[index] do
    with_options module: 'users' do
      resources :projects, only: %w[index]
      resources :tracks, only: %w[index edit update destroy]
      resource :overview, only: %w[show]
    end
  end

  get 'users/:name', to: redirect("/users/%{name}/overview")

  get 'privacy' => "static_pages#privacy", as: :privacy, format: false
  get 'terms' => "static_pages#terms", as: :terms, format: false

  mount PgHero::Engine, at: "pghero"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
