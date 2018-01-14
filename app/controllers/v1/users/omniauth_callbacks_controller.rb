# frozen_string_literal: true

class V1::Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  # include Devise::Controllers::Rememberable

  def assign_provider_attrs(user, auth_hash)
    user_attributes = {}

    if auth_hash['provider'] == 'github'
      user_attributes[:email]      = auth_hash['info']['email']
      user_attributes[:username]   = auth_hash['info']['nickname']
      user_attributes[:first_name] = auth_hash['info']['name'].split.first
      user_attributes[:last_name]  = auth_hash['info']['name'].split.last
    end

    user.assign_attributes(user_attributes)
  end

  def render_data(_message, _data)
    @user = @resource
    build_auth_headers(@user)
    render 'v1/users/show', status: :created
  end

  private

  def build_auth_headers(user)
    response.headers['access-token'] = user['auth_token']
    response.headers['token-type']   = 'Bearer'
    response.headers['expiry']       = user['expiry']
    response.headers['client']       = user['client_id']
    response.headers['uid']          = user['uid']
  end
end
