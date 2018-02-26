# frozen_string_literal: true

json.extract!(
  event,
  :id,
  :title,
  :text,
  :start_time,
  :end_time,
  :online,
  :participants_count,
  :free,
  :author
)
json.views_count event.impressions_count
json.extract!(event, :price) unless event.free?
json.extract!(event, :city, :address, :longitude, :latitude) unless event.online?
json.participants event.participants
