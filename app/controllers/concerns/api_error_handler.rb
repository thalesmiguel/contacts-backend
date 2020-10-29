# frozen_string_literal: true

module ApiErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :respond_with_bad_request_error
    rescue_from ActiveRecord::RecordInvalid, with: :respond_with_record_invalid_error
    rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found_error
  end

  private

  def respond_with_bad_request_error(exception)
    respond_with_application_error(exception, exception, :bad_request)
  end

  def respond_with_record_invalid_error(exception)
    respond_with_application_error(exception, exception.record.errors.messages, :unprocessable_entity)
  end

  def respond_with_not_found_error(exception)
    respond_with_application_error(exception, exception, :not_found)
  end

  def respond_with_application_error(exception, errors, status)
    Rails.logger.warn("Request failed with errors: #{exception.as_json}")

    render json: { errors: errors }, status: status
  end
end
