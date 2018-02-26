# frozen_string_literal: true

json.success true

if @events.empty?
  json.data({})
else
  json.data do
    @events.each do |date, events_per_date|
      json.set! date do
        json.array! events_per_date, partial: 'v1/events/event', as: :event
      end
    end
  end
end
