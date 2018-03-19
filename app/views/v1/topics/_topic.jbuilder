# frozen_string_literal: true

json.extract!(topic, :id, :title, :text, :comments_count, :created_at)
json.views_count(topic.impressions_count)

json.tags topic.tag_list
json.partial!('v1/author/author', author: topic.author)