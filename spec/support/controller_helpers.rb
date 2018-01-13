# frozen_string_literal: true

module ControllerHelpers
  def json
    JSON.parse(response.body)
  end

  def json_success_status
    json['success']
  end

  def json_errors
    json['errors']
  end

  def json_data
    json['data']
  end

  def authenticate_user(user)
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.headers.merge! user.create_new_auth_token
    sign_in user
  end
end