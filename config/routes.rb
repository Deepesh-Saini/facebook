Rails.application.routes.draw do
  root 'welcome#index'

  resources :registrations, only: [:index, :new, :create, :edit, :update] do
    resources :friends, only: [:index, :create, :update, :destroy]
    member do
      get :confirm_email
      get :sent_requests
      get :receive_requests
    end
  end
  resources :passwords, only: [:edit, :update]
  resources :sessions, only: [:create, :destroy]
  resources :posts, except: [:index] do
    resources :likes, only: [:create, :destroy]
    resources :comments
  end

  resources :comments, only: [] do
    resources :replies, only: [:new, :create]
  end

  resources :welcome, only: [:index, :show]

end
