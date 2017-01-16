# frozen_string_literal: true
require 'spec_helper'
RSpec.describe SerializerFieldFilter do
  describe "::init" do
    context "with nil params" do
      subject { SerializerFieldFilter.init }
      it { should be_a SerializerFieldFilter::AllField }
    end

    context "with empty params" do
      subject { SerializerFieldFilter.init([]) }
      it { should be_a SerializerFieldFilter::AllField }
    end

    context "with present params" do
      subject { SerializerFieldFilter.init(['id', 'name']) }
      it { should be_a SerializerFieldFilter }
    end
  end

  describe "#root_fields" do
    context "with fields depth 1" do
      subject { SerializerFieldFilter.init(['id', 'name']).root_fields }
      it { should eq([:id, :name]) }
    end

    context "with fields depth 2" do
      subject { SerializerFieldFilter.init(['id', 'name', 'authors.id', 'authors.name']).root_fields }
      it { should eq([:id, :name, :authors]) }
    end
  end

  describe '#scope_of' do
    context "with none fields" do
      subject { SerializerFieldFilter.init(['id', 'title']).scope_of(:authors) }
      it { should be_a SerializerFieldFilter::NoneField }
    end

    context "with all fields" do
      subject { SerializerFieldFilter.init(['id', 'title', 'authors']).scope_of(:authors) }
      it { should be_a SerializerFieldFilter::AllField }
    end

    context "with partial fields" do
      subject { SerializerFieldFilter.init(['id', 'title', 'authors.id', 'authors.name']).scope_of(:authors) }
      it { should be_a SerializerFieldFilter }
      it { expect(subject.root_fields).to eq([:id, :name])}
    end
  end
end
