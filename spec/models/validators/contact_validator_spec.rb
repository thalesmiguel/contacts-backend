# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/model_validators'

RSpec.describe Validators::ContactValidator, type: :validator do
  class ContactDummy < ApplicationRecord
    include Validators::ContactValidator
  end

  let(:dummy_class) { ContactDummy }

  context 'when included' do
    context 'validating presence of first_name' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :first_name }
        let(:validation) { ActiveRecord::Validations::PresenceValidator }
      end
    end

    context 'validating presence of last_name' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :last_name }
        let(:validation) { ActiveRecord::Validations::PresenceValidator }
      end
    end

    context 'validating presence of phone_number' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :phone_number }
        let(:validation) { ActiveRecord::Validations::PresenceValidator }
      end
    end

    context 'validating presence of email' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :email }
        let(:validation) { ActiveRecord::Validations::PresenceValidator }
      end
    end

    context 'validating uniqueness of email' do
      it_behaves_like 'a validatable class' do
        let(:attribute) { :email }
        let(:validation) { ActiveRecord::Validations::UniquenessValidator }
      end
    end
  end
end
