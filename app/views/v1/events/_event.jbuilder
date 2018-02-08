# frozen_string_literal: true

json.extract!(event, :id, :title, :text, :start_time, :end_time, :online, :author)
json.extract!(event, :city, :address, :longitude, :latitude) unless event.online?
json.participants event.participants
