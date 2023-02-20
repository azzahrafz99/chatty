Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  get 'welcome/index'
  root to: 'welcome#index'

  resources :users, only: [:show]
end
