Rails.application.routes.draw do
  root to: 'customers#index'

  resources :customers do
    resources :orders, only: %i[show] do
      patch 'paid'
      patch 'delivered'
    end
  end

  resources :orders, only: %[index]

  resources :products
end
