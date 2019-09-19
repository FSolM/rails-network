# frozen_string_literal: true

class User
  class RegistrationsController < Devise::RegistrationsController
    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    def new
      @recent_posts = Post.last(2).reverse
      super
    end

    # POST /resource
    def create
      @recent_posts = Post.last(2).reverse
      super
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    end
  end
end
