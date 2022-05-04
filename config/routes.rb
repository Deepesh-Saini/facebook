
Rails.application.routes.draw do
  
  root 'welcome#index'
  
  resources :registrations, only: [:new, :create]
  resources :passwords, only: [:edit, :update] 
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:show, :edit, :update, :new, :create, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments
    end
    resources :comments, only: [] do
      resources :replies, only: [:new, :create]
    end
  resources :welcome, only: [:index, :show]
end