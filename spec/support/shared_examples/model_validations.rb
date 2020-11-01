# frozen_string_literal: true

RSpec.shared_examples 'an invalid model' do
  it 'validates' do
    expect(model).not_to be_valid
    expect(model.errors.messages).to eq(error_messages)
  end
end
