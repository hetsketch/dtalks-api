# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ErrorsRenderer
  include ExceptionHandler
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def pundit_user
    current_v1_user
  end

  #
  #   devise_parameter_sanitizer.permit(:sign_in) do |user|
  #     user.permit(:email, :password, :remember_me)
  #   end
  #
  #   # Avatar crop params should be passed before avatar
  #   devise_parameter_sanitizer.permit(:account_update) do |user|
  #     user.permit(:username, :first_name, :last_name, :position, :bio,
  #                 :city, :current_password, :password,
  #                 :password_confirmation, :avatar_crop_x, :avatar_crop_y,
  #                 :avatar_crop_w, :avatar_crop_h, :avatar)
  #   end
  # end
end
