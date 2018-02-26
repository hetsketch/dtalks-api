# frozen_string_literal: true

class V1::EventsController < ApplicationController
  before_action :authenticate_v1_user!, except: [:show, :index]
  impressionist action: [:show]

  def show
    @event = event
    render 'v1/events/event'
  end

  def index
    @events = params[:status].present? ? Event.past : Event.upcoming
    @events = @events.city_events(params[:cities]) if params[:cities].present?
    @events = Event.group_by_day(@events)
  end

  def update
    @event = event
    @event.update!(event_params)
    render 'v1/events/event'
  end

  def destroy
    event.destroy
    render json: { success: true }, status: :ok
  end

  def create
    @event = Event.new(event_params)
    @event.author = current_v1_user
    @event.participants.build(user: current_v1_user, event: @event)
    @event.save!
    render 'v1/events/event', status: :created
  end

  private

  def event_params
    params.permit(:id, :title, :text, :start_time, :end_time, :city, :user_id, :photo, :online, :address, :latitude,
                  :longitude, :price, :free)
  end

  def event
    Event.find(params[:id])
  end
end
