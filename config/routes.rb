Rails.application.routes.draw do

  resources :posts
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  resources :users
  root to: "users#index"

  get 'countries/fetch_cities'
end
