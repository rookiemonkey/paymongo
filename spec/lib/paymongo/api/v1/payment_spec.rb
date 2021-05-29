require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::PaymentRecord do
    describe '.create_payment' do
      it 'responds to create_payment method' do
        expect(described_class.respond_to?('create_payment')).to eq(true)
      end
    end

    describe '.retrieve_payment' do
      it 'responds to retrieve_payment method' do
        expect(described_class.respond_to?('retrieve_payment')).to eq(true)
      end
    end

    describe '.list_all_payments' do
      it 'responds to list_all_payments method' do
        expect(described_class.respond_to?('list_all_payments')).to eq(true)
      end
    end
  end
end