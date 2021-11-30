Rails.application.routes.draw do
  resources :users
  root to: "users#index"

  get 'countries/fetch_cities'
end
