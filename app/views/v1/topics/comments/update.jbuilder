# frozen_string_literal: true

json.success true

json.data do
  json.partial! 'v1/topics/comments/comment', comment: @comment
end
