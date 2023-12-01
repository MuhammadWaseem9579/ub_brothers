# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboards#dashboard'

  resources :parties do
    resources :tickets do
      post '/refund', to: 'tickets#refund'
    end

    resources :payments
    resources :hajj_and_umrahs
  end
end
