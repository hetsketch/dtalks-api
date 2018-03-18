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
    @comment = comment(params[:id])
    @comment.update!(comment_params)
  end

  def destroy
    comment(params[:id]).destroy!
    render json: { success: true }, status: :ok
  end

  def index
    @comments = @commentable.comments.includes(:author)
  end

  private

  def comment_params
    params.permit(:text)
  end

  def comment(id)
    Comment.find(id)
  end
end
