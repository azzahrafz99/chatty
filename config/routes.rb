Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  root to: 'rooms#index'

  resources :users, only: [:show]
  get 'users/:id/direct', to: 'users#direct_message', as: 'direct_message'
  
  resources :rooms do
    resources :messages
  end
end
