# frozen_string_literal: true

class V1::TopicsController < ApplicationController
  before_action :authenticate_v1_user!, except: [:show, :index]
  impressionist :action => [:show]

  def index
    @topics = Topic.includes(:author).all.recently_added
  end

  def show
    @topic = Topic.includes([:comments => :author]).find(params[:id])
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.author = current_v1_user
    @topic.save!
    render status: :created
  end

  def update
    topic.update!(topic_params)
    render 'v1/topics/show'
  end

  def destroy
    topic&.destroy
    render json: { success: true }, status: :ok
  end

  private

  def topic_params
    params.permit(:title, :text)
  end

  def topic
    @topic ||= Topic.find(params[:id])
  end
end
