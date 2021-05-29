require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::TokenRecord do
    describe '.create_token' do
      it 'responds to create_token method' do
        expect(described_class.respond_to?('create_token')).to eq(true)
      end
    end

    describe '.retrieve_token' do
      it 'responds to retrieve_token method' do
        expect(described_class.respond_to?('retrieve_token')).to eq(true)
      end
    end
  end
end