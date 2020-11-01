# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/model_validators'

RSpec.describe Validators::ContactValidator, type: :validator do
  class ContactDummy < ApplicationRecord
    include Validators::ContactValidator
  end

  let(:dummy_class) { ContactDummy }

  context 'when included' do
    context 'validating first_name' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :first_name }
        let(:validators) { [ActiveRecord::Validations::PresenceValidator] }
      end
    end

    context 'validating last_name' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :last_name }
        let(:validators) { [ActiveRecord::Validations::PresenceValidator] }
      end
    end

    context 'validating phone_number' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :phone_number }
        let(:validators) do
          [
            ActiveRecord::Validations::PresenceValidator,
            Validators::PhoneNumberValidator
          ]
        end
      end
    end

    context 'validating email' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :email }
        let(:validators) do
          [
            ActiveRecord::Validations::PresenceValidator,
            ActiveRecord::Validations::UniquenessValidator,
            Validators::EmailValidator
          ]
        end
      end
    end
  end
end
