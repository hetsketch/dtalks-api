# frozen_string_literal: true

json.author do
  json.extract!(author, :id, :full_name, :username, :position)
  json.avatar do
    json.original avatar_url(author)
    json.thumbnail avatar_url(author, size: :thumbnail)
  end
end