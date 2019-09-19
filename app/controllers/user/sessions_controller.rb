# frozen_string_literal: true

class User
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
      @recent_posts = Post.last(2).reverse
      super
    end
    
  end
end
