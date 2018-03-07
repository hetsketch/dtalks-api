# frozen_string_literal: true

class V1::Users::SessionsController < DeviseTokenAuth::SessionsController
  def render_create_success
    @user = @resource
    render 'v1/users/show', status: :created
  end
end