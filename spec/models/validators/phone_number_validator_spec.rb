# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/attribute_validators'

RSpec.describe Validators::PhoneNumberValidator, type: :validator do
  let(:validator) { described_class.new(attributes: [:phone_number]) }
  let(:record) { Struct.new(:phone_number, :errors).new }
  let(:attribute) { :phone_number }

  before(:each) do
    allow(record).to receive(:errors).and_return(ActiveModel::Errors.new(record))
    allow(record).to receive(:phone_number)
  end

  context 'when phone_number is valid' do
    phone_numbers = %w[
      (+351) 282 43 50 50
      90191919908
      555-8909
      001 6867684
      001 6867684x1
      1 (234) 567-8901
      1-234-567-8901 x1234
      1-234-567-8901 ext1234
      1-234 567.89/01 ext.1234
      1(234)5678901x1234
      (123)8575973
      (0055)(123)8575973
    ]

    phone_numbers.each do |phone_number|
      it_behaves_like 'a valid attribute', phone_number do
        let(:value) { phone_number }
      end
    end
  end

  context 'when phone_number is invalid' do
    phone_numbers = %w[
      +++1124
      !@#!@#!@
    ]

    phone_numbers.each do |phone_number|
      it_behaves_like 'an invalid attribute', phone_number do
        let(:value) { phone_number }
      end
    end
  end
end
