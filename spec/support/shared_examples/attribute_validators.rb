# frozen_string_literal: true

RSpec.shared_examples 'a valid attribute' do |value|
  it "succeeds with #{value}" do
    validator.validate_each(record, attribute, value)
    expect(record).not_to have_received(:errors)
  end
end

RSpec.shared_examples 'an invalid attribute' do |value|
  it "fails with #{value}" do
    validator.validate_each(record, attribute, value)
    expect(record).to have_received(:errors)
  end
end
