require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::PaymentMethodRecord do
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