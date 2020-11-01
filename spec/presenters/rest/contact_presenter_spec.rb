# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rest::ContactPresenter, type: :presenter do
  let(:model) { contact }
  subject { described_class.new(model) }

  describe '#as_json' do
    context 'when the model is present' do
      let(:contact) { create(:contact) }
      before { travel_to Time.local(2020) }

      it "presents the model's attributes" do
        expect(subject.as_json).to eq(contact.attributes)
      end
    end

    context 'when the model is not present' do
      let(:contact) { nil }

      it "returns nil" do
        expect(subject.as_json).to eq(nil)
      end
    end
  end
end
