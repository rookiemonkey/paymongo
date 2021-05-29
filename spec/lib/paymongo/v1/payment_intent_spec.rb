require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::PaymentIntentRecord do
    describe '.create_payment_intent' do
      it 'responds to create_payment_intent method' do
        expect(described_class.respond_to?('create_payment_intent')).to eq(true)
      end
    end

    describe '.retrieve_payment_intent' do
      it 'responds to retrieve_payment_intent method' do
        expect(described_class.respond_to?('retrieve_payment_intent')).to eq(true)
      end
    end

    describe '.attach_to_payment_intent' do
      it 'responds to attach_to_payment_intent method' do
        expect(described_class.respond_to?('attach_to_payment_intent')).to eq(true)
      end
    end
  end
end