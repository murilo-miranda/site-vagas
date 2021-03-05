Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  devise_for :users
  #devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :companies, only: [:show, :edit, :update]
  resources :vacancies, only: [:index, :new, :create, :show] do
    post 'apply', on: :member
    get 'candidates', on: :collection
  end
  resources :accounts, only: [:show, :edit, :update] do
    get 'applications', on: :collection
  end
  resources :offers, only: [:new, :create]
end
