# frozen_string_literal: true

json.success true

json.data do
  json.comments @comments, partial: 'v1/topics/comments/comment', as: :comment
end
