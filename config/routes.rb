# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create update destroy]
  resources :tickets, only: %i[index show create update destroy]
  resource :session, only: %i[create destroy]
  resources :projects, only: %i[index show create update destroy]

  root 'tickets#index'
end
