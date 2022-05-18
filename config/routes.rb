Rails.application.routes.draw do
  get 'rooms/index'
  root 'welcome#index'

  resources :registrations, except: [:destroy, :show] do
    member do
      get :confirm_email
    end
  end

  resources :friends, only: [:show, :update, :destroy] do
    member do
      post :create
    end
  end

  resources :findfriends, only: [:index] do
    member do
      get :sent_requests
      get :receive_requests
    end
  end


  resources :passwords, only: [:edit, :update]
  resources :sessions, only: [:create, :destroy]
  resources :posts, except: [:index] do
    resources :likes, only: [:create, :destroy]
    resources :comments do
      resources :replies, only: [:create]
    end
  end

  resources :welcome, only: [:index, :show]

  resources :rooms do
    resources :messages
  end

end
