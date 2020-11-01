# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/attribute_validators'

RSpec.describe Validators::EmailValidator, type: :validator do
  let(:validator) { described_class.new(attributes: [:email]) }
  let(:record) { Struct.new(:email, :errors).new }
  let(:attribute) { :email }

  before(:each) do
    allow(record).to receive(:errors).and_return(ActiveModel::Errors.new(record))
    allow(record).to receive(:email)
  end

  context 'when email is valid' do
    emails = %w[
      my.email@something.com
      my_email@something.com
    ]

    emails.each do |email|
      it_behaves_like 'a valid attribute', email do
        let(:value) { email }
      end
    end
  end

  context 'when email is invalid' do
    emails = %w[
      some_string
      test@@test.com
    ]

    emails.each do |email|
      it_behaves_like 'an invalid attribute', email do
        let(:value) { email }
      end
    end
  end
end
