# frozen_string_literal: true

RSpec.shared_context 'contacts' do
  let!(:contact_1) { create(:contact) }
  let!(:contact_2) { create(:contact) }
  let!(:contact_3) { create(:contact) }
end
