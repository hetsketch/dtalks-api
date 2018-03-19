# frozen_string_literal: true

json.author do
  json.extract!(author, :id, :full_name, :username, :position)
  if author.avatar.present?
    json.avatar do
      json.original  author.avatar[:original].url
      json.thumbnail author.avatar[:thumbnail].url
    end
  end
end