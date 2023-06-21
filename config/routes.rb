Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :users, except: %i[index new]
  resources :posts, except: :index do
    resources :likes, only: %i[create destroy]
  end
  resources :categories, only: :show
end
