# frozen_string_literal: true

json.extract!(user, :id, :username, :email, :first_name, :last_name, :full_name, :position, :bio, :city, :links)

json.company do
  user.company.present? ? json.extract!(user.company, :id, :name) : json.merge!({})
end

json.avatar do
  json.original avatar_url(user)
  json.thumbnail avatar_url(user, size: :thumbnail)
end
