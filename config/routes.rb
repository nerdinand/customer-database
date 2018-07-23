Rails.application.routes.draw do
  root to: 'customers#index'

  resources :customers do
    resources :orders, only: %i[show]
  end

  resources :orders, only: %[index]

  resources :products, only: %i[index show]
end
