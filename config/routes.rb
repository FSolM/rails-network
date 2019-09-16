# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'user/confirmations',
                                    passwords: 'user/passwords',
                                    registrations: 'user/registrations',
                                    sessions: 'user/sessions',
                                    unlocks: 'user/unlocks',
                                    omniauth_callbacks: 'user/omniauth_callbacks' }

  resources :friendships, only: %i[create destroy]
  resources :posts, only: %i[new create show destroy edit update] do
    resources :comments, only: %i[new create destroy edit update]
  end
  resources :friendships, only: %i[show]
  resources :reactions, only: %i[create destroy update]
  resources :users, only: %i[show edit update]

  get 'add_friend', to: 'friendships#add_friend'
  get 'cancel_friend_request', to: 'friendships#cancel_friend_request'
  get 'accept_friend_request', to: 'friendships#accept_friend_request'
  get 'remove_friend', to: 'friendships#remove_friend'
  get 'decline_friend_request', to: 'friendships#decline_friend_request'

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

  get '/feed', to: 'feed#index'
end
