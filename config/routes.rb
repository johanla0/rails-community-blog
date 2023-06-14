Rails.application.routes.draw do
  root 'posts#index'

  resources :users, except: :index
  resources :posts, except: :index
end
