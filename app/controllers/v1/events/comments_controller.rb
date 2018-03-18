# frozen_string_literal: true

class V1::Events::CommentsController < V1::CommentsController
  before_action :set_commentable, only: [:create, :update, :index]

  def set_commentable
    @commentable ||= Event.find(params[:event_id])
  end
end