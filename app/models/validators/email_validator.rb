# frozen_string_literal: true

module Validators
  # Validator for email format
  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank? || valid_email?(value)

      record.errors.add(attribute, options[:message] || 'is invalid')
    end

    private

    def valid_email?(email)
      email.match?(URI::MailTo::EMAIL_REGEXP)
    end
  end
end
