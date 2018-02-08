# frozen_string_literal: true

json.success true

if @grouped_events.empty?
  json.data({})
else
  json.data do
    @grouped_events.each do |date, events_per_date|
      json.set! date do
        json.array! events_per_date, partial: 'v1/events/event', as: :event
      end
    end
  end
end
