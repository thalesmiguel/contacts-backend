# frozen_string_literal: true

module Validators
  # Validator for phone number format
  class PhoneNumberValidator < ActiveModel::EachValidator
    PHONE_NUMBER_REGEX = %r{
      \A(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-.\ \\/]?)
        ?((?:\(?\d{1,}\)?[\-.\ \\/]?){0,})(?:[\-.\ \\/]
          ?(?:ext\.?|extension|x)[\-.\ \\/]?(\d+))?\z
    }x.freeze

    def validate_each(record, attribute, value)
      return if value.blank? || valid_phone_number?(value)

      record.errors.add(attribute, options[:message] || 'is invalid')
    end

    private

    def valid_phone_number?(phone_number)
      phone_number.match?(PHONE_NUMBER_REGEX)
    end
  end
end
