# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/model_validators'

RSpec.describe ApiErrorHandler, type: :concern do
  class ApiErrorDummy < ActionController::API
    include ApiErrorHandler
  end

  context 'when included' do
    it 'includes rescue handlers' do
      expect(ApiErrorDummy.rescue_handlers).to eq(
        [
          ['ActionController::ParameterMissing', :respond_with_bad_request_error],
          ['ActiveRecord::RecordInvalid', :respond_with_record_invalid_error],
          ['ActiveRecord::RecordNotFound', :respond_with_not_found_error]
        ]
      )
    end
  end
end
