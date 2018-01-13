# frozen_string_literal: true

class V1::Topics::CommentsController < V1::CommentsController
  before_action :set_commentable, only: [:create, :update]

  def set_commentable
    @commentable ||= Topic.find(params[:topic_id])
  end
end