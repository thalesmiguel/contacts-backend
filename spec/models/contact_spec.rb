# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_contexts/shared_contacts'
require 'support/shared_examples/model_validations'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    context 'without a first_name' do
      it_behaves_like 'an invalid model' do
        let(:model) { build(:contact, first_name: nil) }
        let(:error_messages) { { first_name: ["can't be blank"] } }
      end
    end

    context 'without a last_name' do
      it_behaves_like 'an invalid model' do
        let(:model) { build(:contact, last_name: nil) }
        let(:error_messages) { { last_name: ["can't be blank"] } }
      end
    end

    context 'without a phone_number' do
      it_behaves_like 'an invalid model' do
        let(:model) { build(:contact, phone_number: nil) }
        let(:error_messages) { { phone_number: ["can't be blank"] } }
      end
    end

    context 'without an email' do
      it_behaves_like 'an invalid model' do
        let(:model) { build(:contact, email: nil) }
        let(:error_messages) { { email: ["can't be blank"] } }
      end
    end

    context 'with an invalid email' do
      it_behaves_like 'an invalid model' do
        let(:model) { build(:contact, email: 'some_string') }
        let(:error_messages) { { email: ['is invalid'] } }
      end
    end

    context 'with duplicated email' do
      let(:previous_contact) { create(:contact) }

      it_behaves_like 'an invalid model' do
        let(:model) { build(:contact, email: previous_contact.email) }
        let(:error_messages) { { email: ['has already been taken'] } }
      end
    end
  end

  describe 'versioning' do
    let(:contact) { create(:contact, first_name: 'First-Name') }

    with_versioning do
      it 'is versioned' do
        contact.update!(first_name: 'New-First-Name')
        expect(contact).to have_a_version_with(first_name: 'First-Name')
      end
    end
  end

  describe 'scopes' do
    context '.sorted' do
      include_context 'named contacts'

      it 'returns a list of sorted contacts' do
        expect(described_class.sorted.pluck(:first_name, :id)).to eq(
          [['A-Name', 3], ['B-Name', 2], ['C-Name', 1]]
        )
      end
    end
  end
end
