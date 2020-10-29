RSpec.shared_examples "a validatable class" do
  it 'includes the validation' do
    expect(dummy_class._validators[attribute]).to include(validation)
  end
end
