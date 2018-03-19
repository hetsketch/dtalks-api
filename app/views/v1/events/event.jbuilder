# frozen_string_literal: true

json.success true

json.data do
  json.partial! 'v1/events/event', event: @event
  json.comments @event.comments, partial: 'v1/comments/comment', as: :comment
end
