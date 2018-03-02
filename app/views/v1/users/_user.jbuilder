# frozen_string_literal: true

json.extract!(user, :id, :username, :email, :first_name, :last_name, :position, :bio, :city)
json.avatar do
  json.data_uri user.avatar.data_uri
end
