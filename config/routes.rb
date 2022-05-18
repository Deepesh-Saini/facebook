Rails.application.routes.draw do
  root 'welcome#index'

  resources :registrations, except: [:destroy, :show, :index] do
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
  resources :posts, except: [:index, :show] do
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
