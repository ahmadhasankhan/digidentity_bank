Rails.application.routes.draw do
  devise_for :users

  #get '/business/:id', to: 'businesses#show', as: 'business'

  resources :businesses do
    resources :transactions, only: [:new, :index, :create] do
      member do
        get 'receipt'
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
