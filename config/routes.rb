# frozen_string_literal: true

Rails.application.routes.draw do
  resources :quotes

  # Defines the root path route ("/")
  root 'quotes#index'
end
