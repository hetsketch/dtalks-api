# frozen_string_literal: true

class V1::CommentsController < ApplicationController
  before_action :authenticate_v1_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.author = current_v1_user

    @comment.save!
    render status: :created
  end

  def update
    comment.update!(comment_params)
  end

  def destroy
    comment&.destroy!
    render json: { success: true }, status: :ok
  end

  private

  def comment_params
    params.permit(:text)
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end
end
