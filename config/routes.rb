Rails.application.routes.draw do
  root to: "toppages#index"
  devise_for :users
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
end
