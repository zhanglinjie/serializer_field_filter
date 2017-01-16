require "spec_helper"
describe SerializerFieldFilter::NoneField do
  subject(:filter) { SerializerFieldFilter::NoneField.new }
  describe '#root_fields' do
    it { expect(filter.root_fields).to eq([]) }
  end

  describe '#scope_of' do
    it { expect(filter.scope_of(:authors)).to be_a SerializerFieldFilter::NoneField }
  end
end
