# frozen_string_literal: true

RSpec.shared_examples 'a validatable class' do
  it 'includes the validation' do
    expect(dummy_class._validators[attribute].map(&:class)).to eq(validators)
  end
end
