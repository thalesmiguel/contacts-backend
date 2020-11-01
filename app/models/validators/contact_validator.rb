# frozen_string_literal: true

module Validators
  module ContactValidator
    extend ActiveSupport::Concern

    included do
      validates :first_name, :last_name, :email, :phone_number, presence: true
      validates :email, uniqueness: true
      validates :email, 'validators/email': true
    end
  end
end
