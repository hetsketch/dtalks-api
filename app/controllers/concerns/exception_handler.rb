# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |ex|
      render_not_found(ex)
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      render_unprocessable(ex)
    end

    rescue_from Pundit::NotAuthorizedError do |ex|
      render_forbidden(ex)
    end
  end
end
