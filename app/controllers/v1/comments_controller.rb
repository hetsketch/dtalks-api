# frozen_string_literal: true

class V1::CommentsController < ApplicationController
  before_action :authenticate_v1_user!, except: [:index]

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.author = current_v1_user
    authorize @comment

    @comment.save!
    render status: :created
  end

  def update
    @comment = comment(params[:id])
    authorize @comment
    @comment.update!(comment_params)
  end

  def destroy
    @comment = comment(params[:id])
    authorize @comment
    @comment.destroy!
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
