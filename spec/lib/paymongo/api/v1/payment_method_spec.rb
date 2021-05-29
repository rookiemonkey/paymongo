require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::PaymentMethodRecord do
    describe 'class variables' do
      it 'has base_url pointing to payment method route' do
        expect(described_class.base_url).to eq("#{Paymongo::Api::V1::Config.base_url}/payment_methods")
      end
    end

    describe '.create_payment_method' do
      it 'responds to create_payment_method method' do
        expect(described_class.respond_to?('create_payment_method')).to eq(true)
      end
    end

    describe '.retrieve_payment_method' do
      it 'responds to retrieve_payment_method method' do
        expect(described_class.respond_to?('retrieve_payment_method')).to eq(true)
      end
    end
  end
end