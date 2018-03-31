# frozen_string_literal: true

json.extract!(user, :id, :username, :email, :first_name, :last_name, :full_name, :position, :bio, :city)
json.avatar do
  json.original avatar_url(user)
  json.thumbnail avatar_url(user, size: :thumbnail)
end
