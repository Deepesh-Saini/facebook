Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :registrations, except: [:destroy, :show, :index] do
    member do
      get :confirm_email
    end
  end

  resources :friends, only: [:index, :update, :destroy] do
    member do
      post :create
    end
  end

  resources :find_friends, only: [:index] do
    member do
      get :sent_requests
      get :receive_requests
    end
  end


  resources :passwords, only: [:edit, :update]
  resources :sessions, only: [:create, :destroy]
  resources :posts, except: [:show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:new, :create] do
      resources :replies, only: [:create]
    end
  end

  resources :welcome, only: [:index, :show]

  resources :rooms, only: [:index, :show] do
    resources :messages, only: [:create]
  end

end
