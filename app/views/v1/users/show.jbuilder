# frozen_string_literal: true

json.success true

json.data do
  json.partial! 'v1/users/user', user: @user
end
