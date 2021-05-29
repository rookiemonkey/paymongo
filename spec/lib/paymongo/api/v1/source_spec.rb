require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::SourceRecord do
    describe '.create_source' do
      it 'responds to create_source method' do
        expect(described_class.respond_to?('create_source')).to eq(true)
      end
    end

    describe '.retrieve_source' do
      it 'responds to retrieve_source method' do
        expect(described_class.respond_to?('retrieve_source')).to eq(true)
      end
    end
  end
end