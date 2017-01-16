require "spec_helper"
describe SerializerFieldFilter::AllField do
  subject(:filter) { SerializerFieldFilter::AllField.new }
  describe '#root_fields' do
    it { expect(filter.root_fields).to eq(nil) }
  end

  describe '#scope_of' do
    it { expect(filter.scope_of(:authors)).to be_a SerializerFieldFilter::AllField }
  end
end
