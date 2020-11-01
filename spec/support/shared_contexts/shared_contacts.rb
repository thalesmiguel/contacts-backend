# frozen_string_literal: true

RSpec.shared_context 'contacts' do
  let!(:contact_1) { create(:contact) }
  let!(:contact_2) { create(:contact) }
  let!(:contact_3) { create(:contact) }
end

RSpec.shared_context 'named contacts' do
  let!(:contact_1) { create(:contact, id: 1, first_name: 'C-Name') }
  let!(:contact_2) { create(:contact, id: 2, first_name: 'B-Name') }
  let!(:contact_3) { create(:contact, id: 3, first_name: 'A-Name') }
end
