# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_contexts/shared_contacts'

RSpec.describe ContactsService, type: :service do
  subject { described_class.new }

  describe '#all' do
    context 'when there are Contacts' do
      include_context 'named contacts'

      it 'returns all availabe Contacts' do
        expect(subject.all).to eq([contact_3, contact_2, contact_1])
      end
    end

    context 'when there are not Contacts' do
      it 'returns an empty list' do
        expect(subject.all).to eq([])
      end
    end
  end

  describe '#find' do
    context 'when a contact is found' do
      include_context 'contacts'

      it 'returns only the requested Contact' do
        expect(subject.find(contact_1.id)).to eq(contact_1)
      end
    end

    context 'when the Contact is not found' do
      it 'raises an error' do
        expect { subject.find(9_999_999) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#history' do
    context 'when a Contact is found' do
      let(:contact) { create(:contact, first_name: 'Original-First-Name', last_name: 'Original-Last-Name') }

      context 'when there is a history of updates' do
        before do
          travel_to Time.zone.local(2020)
          contact.update!(first_name: 'New-Name', last_name: 'New-Last-Name')
          contact.update!(first_name: 'Another-New-Name')
        end

        with_versioning do
          it 'returns the history of updates' do
            expect(subject.history(contact.id).size).to eq(2)
            expect(subject.history(contact.id).first.class).to eq(PaperTrail::Version)
          end
        end
      end

      context 'when there is not a history of updates' do
        it 'returns an empty list' do
          expect(subject.history(contact.id)).to eq([])
        end
      end
    end

    context 'when the Contact is not found' do
      it 'raises an error' do
        expect { subject.history(9_999_999) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    context 'when the Contact is created' do
      let(:params) { attributes_for(:contact) }

      it 'creates a new contact' do
        expect { subject.create(params) }.to change { Contact.count }.by(1)
      end
    end

    context 'when the Contact creation fails' do
      include_context 'contacts'
      let(:params) { contact_1.attributes }

      it 'raises an error' do
        expect { subject.create(params) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#update' do
    include_context 'contacts'

    context 'when the Contact is updated' do
      let(:params) { attributes_for(:contact, first_name: 'New-Name') }

      it 'updates the contact' do
        expect { subject.update(contact_1.id, params) }.to change { contact_1.reload.first_name }.to('New-Name')
      end
    end

    context 'when the Contact update fails' do
      let(:params) { contact_2.attributes }

      it 'raises an error' do
        expect { subject.update(contact_1.id, params) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#destroy' do
    include_context 'contacts'

    context 'when the Contact is destroyed' do
      it 'creates a new contact' do
        expect { subject.destroy(contact_1.id) }.to change { Contact.count }.by(-1)
      end
    end

    context 'when the Contact is not found' do
      it 'raises an error' do
        expect { subject.destroy(9_999_999) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
