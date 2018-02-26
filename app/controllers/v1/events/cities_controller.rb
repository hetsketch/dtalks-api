# frozen_string_literal: true

class V1::Events::CitiesController < ApplicationController
  def index
    @cities = Event.pluck('DISTINCT city')
  end
end
