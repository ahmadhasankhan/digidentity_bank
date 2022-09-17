Rails.application.routes.draw do
  resources :businesses
  resources :properties
  resources :bids
  devise_for :users

  resources :properties do
    resources :bids, only: [:new, :index, :create, :destroy]
  end

  get 'accounts/my_accounts'
  get '/accounts/:id', to: 'accounts#show', as: 'account'


  resources :accounts do
    resources :transactions, only: [:new, :index, :create]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
