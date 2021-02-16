Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  devise_for :users
  #devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :companies, only: [:index, :show, :edit, :update]
end
