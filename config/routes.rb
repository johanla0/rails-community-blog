Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :users, except: %i[index new]
  resources :posts, except: :index do
    resources :likes, only: %i[create destroy], module: :posts
    resources :comments, except: %i[index new show], module: :posts do
      get :respond
    end
  end
  resources :categories, only: :show
end
