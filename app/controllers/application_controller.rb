# frozen_string_literal: true

# Base Application Controller; contains general methods & params
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name birth_day])
  end
end
