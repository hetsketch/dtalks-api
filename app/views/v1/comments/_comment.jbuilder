# frozen_string_literal: true

json.extract!(comment, :id, :text, :created_at)

json.author do
  json.extract!(comment.author, :id, :full_name, :username, :position)
end
