# frozen_string_literal: true

json.success true

json.data do
  json.partial! 'v1/topics/topic', topic: @topic
  json.comments @topic.comments, partial: 'v1/comments/comment', as: :comment
end
