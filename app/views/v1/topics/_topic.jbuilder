# frozen_string_literal: true

json.extract!(topic, :id, :title, :text, :comments_count, :created_at)
json.views_count(topic.impressions_count)

json.tags do
  json.array!(topic.tag_list)
end

json.author do
  json.extract!(topic.author, :id, :full_name, :username, :position)
end
