# frozen_string_literal: true

class V1::EventsController < ApplicationController
  before_action :authenticate_v1_user!, except: [:show, :index]

  def show
    @event = event
    render 'v1/events/event'
  end

  def index
    @grouped_events = Event.future.group_by { |e| e.start_time.strftime('%Y-%m-%d') }
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
    @event.participants << current_v1_user
    @event.save!
    render 'v1/events/event', status: :created
  end

  private

  def event_params
    params.permit(:id, :title, :text, :start_time, :end_time, :user_id, :photo)
  end

  def event
    Event.find(params[:id])
  end
end
