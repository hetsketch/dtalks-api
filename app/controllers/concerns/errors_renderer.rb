# frozen_string_literal: true

module ErrorsRenderer
  def render_not_found(exception)
    render_json_errors(exception.message, :not_found)
  end

  def render_unprocessable(exception)
    render_json_errors(exception.record.errors, :unprocessable_entity)
  end

  private

  def render_json_errors(errors, status)
    render json: {
      success: false,
      errors: errors
    }, status: status
  end
end