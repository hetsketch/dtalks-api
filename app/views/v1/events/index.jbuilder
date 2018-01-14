# frozen_string_literal: true

json.success true

json.data do
  json.array! @events, partial: 'v1/events/event', as: :event
end
