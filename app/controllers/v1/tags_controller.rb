# frozen_string_literal: true

class V1::TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{params[:s]}%").pluck(:name)
    render json: { success: true, data: { tags: @tags } }, status: :ok
  end
end
