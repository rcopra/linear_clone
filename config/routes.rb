# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index create]
  resource :session, only: %i[create destroy]

  root 'users#index'
end
