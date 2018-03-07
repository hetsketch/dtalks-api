# frozen_string_literal: true

json.extract!(user, :id, :username, :email, :first_name, :last_name, :full_name, :position, :bio, :city)
if user.avatar.present?
  json.avatar do
    json.data_uri user.avatar.data_uri
  end
end
