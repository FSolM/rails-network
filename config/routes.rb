Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: "user/confirmations",
                                    passwords: "user/passwords",
                                    registrations: "user/registrations",
                                    sessions: "user/sessions",
                                    unlocks: "user/unlocks",
                                    omniauth_callbacks: "user/omniauth_callbacks",
                                  }

  resources :friendships, only: [:create, :destroy]
  resources :posts, only: [:new, :create, :show, :destroy, :edit, :update] do
    resources :comments, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :reactions, only: [:create, :destroy, :update]
  resources :users, only: [:show, :edit, :update]

  post '/react', to: 'reactions#react'

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    authenticated :user do
      root 'feed#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'user/sessions#new', as: :unauthenticated_root
    end
  end

  get "/feed", to: "feed#index"
end
