Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  get 'feed/index'
  devise_for :users, controllers: { confirmations: "user/confirmations",
                                    passwords: "user/passwords",
                                    registrations: "user/registrations",
                                    sessions: "user/sessions",
                                    unlocks: "user/unlocks",
                                    omniauth_callbacks: "user/omniauth_callbacks",
                                  }

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end
end
