# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :users, only: %i[show edit update destroy]
  resources :posts, only: %i[show new edit create update destroy] do
    resources :likes, only: %i[create destroy], module: :posts
    resources :comments, only: %i[edit create update destroy], module: :posts do
      get :respond
    end
  end
  resources :categories, only: :show
end
