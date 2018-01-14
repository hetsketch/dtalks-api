# frozen_string_literal: true

class V1::UsersController < ApplicationController
  before_action :authenticate_v1_user!

  def index
  end

  def show
  end

  def create
    # auth = request.env['omniauth.auth']
    # if auth
    #   @user = User.create_with_omniauth(auth)
    #   sign_in_and_redirect @user, event: :authentication if @user.persisted?
    # else
    #   sign_up
    # end
    #
    # session[:user_id] = @user.id
    # redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    # session[:user_id] = nil
    # redirect_to root_url, notice: 'Signed out!'
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation, :remember_me,
      :first_name, :last_name, :address, :city, :bio, :avatar,
      :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h
    )
  end
end
