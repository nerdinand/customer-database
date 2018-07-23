Rails.application.routes.draw do
  root to: 'customers#index'

  resources :customers, only: %i[index show] do
    resources :orders, only: %i[show]
  end

  resources :orders, only: %[index]

  resources :products, only: %i[index show]
end
