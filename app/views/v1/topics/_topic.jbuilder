# frozen_string_literal: true

json.extract!(topic, :id, :title, :text, :created_at)
json.views_count(topic.impressions_count)

json.author do
  json.extract!(topic.author, :first_name, :last_name, :username)
end

json.comments(topic.comments)
