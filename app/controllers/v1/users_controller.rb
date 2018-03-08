# frozen_string_literal: true

class V1::UsersController < ApplicationController
  before_action :authenticate_v1_user!

  def index
  end

  def show
    @user = User.includes(:events, :comments, :topics, :company).find(params[:id])
    render 'v1/users/user_profile'
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
    params.permit(
      :username, :email, :password, :password_confirmation, :remember_me,
      :first_name, :last_name, :address, :city, :bio, :avatar
    )
  end

  def user
    User.find(params[:id])
  end
end
