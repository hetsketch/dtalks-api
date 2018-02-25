# frozen_string_literal: true

class V1::CommentsController < ApplicationController
  before_action :authenticate_v1_user!, except: [:index]

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

  def index
    @comments = @commentable.comments.includes(:author)
    render 'v1/topics/comments/index'
  end

  private

  def comment_params
    params.permit(:text)
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end
end
