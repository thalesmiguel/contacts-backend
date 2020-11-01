# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rest::ContactHistoryPresenter, type: :presenter do
  let(:versions) { contact.versions }
  subject { described_class.new(versions) }

  describe '#as_json' do
    context 'when the versions is present' do
      let(:contact) { create(:contact, first_name: 'Original-First-Name') }
      before do
        travel_to Time.zone.local(2020)
        contact.update!(first_name: 'New-First-Name')
      end

      with_versioning do
        it 'presents the history of updates' do
          expect(subject.as_json).to eq(
            [
              {
                updated_at: 'Wed, 01 Jan 2020 00:00:00 UTC +00:00',
                changes: [
                  { attribute: 'first_name', old_value: 'Original-First-Name', new_value: 'New-First-Name' }
                ]
              }
            ]
          )
        end
      end
    end

    context 'when the versions is not present' do
      let(:versions) { nil }

      it 'returns an empty array' do
        expect(subject.as_json).to eq([])
      end
    end
  end
end
