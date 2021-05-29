require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::Interfaces::Billing do
    let(:attributes) do
      { 
        name: 'Makisu', 
        email: 'makisu@gmail.com',
        phone: '4196396',
        address: { 
          line1: 'Blk1 Lot2 Maginhawa St.', 
          line2: 'Brgy. Iniwan', 
          city: 'Quezon City', 
          state: 'NCR',
          postal_code: '1117',
          country: 'PH'
        }
      }
    end

    describe 'Valid Billing' do
      let(:billing) { described_class.new(attributes) }

      it 'is an instance of Interfaces::Billing' do
        expect(billing.class).to eq(described_class)
      end

      it 'has name and its a string' do
        expect(billing.respond_to?('name')).to eq(true)
        expect(billing.name).to eq(attributes[:name])
        expect(billing.name.class).to eq(String)
      end

      it 'has email and its a string' do
        expect(billing.respond_to?('email')).to eq(true)
        expect(billing.email).to eq(attributes[:email])
        expect(billing.email.class).to eq(String)
      end

      it 'has phone and its a string' do
        expect(billing.respond_to?('phone')).to eq(true)
        expect(billing.phone).to eq(attributes[:phone])
        expect(billing.phone.class).to eq(String)
      end

      it 'has address and its an intance of Interfaces::Address' do
        expect(billing.respond_to?('address')).to eq(true)
        expect(billing.address.class).to eq(Paymongo::Api::V1::Interfaces::Address)
      end
    end

    describe 'Valid Billing' do
      it 'accepts empty name' do
        attributes.reject! { |k,v| k == :name }
        expect(described_class.new(attributes).name).to eq(nil)
      end

      it 'accepts empty email' do
        attributes.reject! { |k,v| k == :email }
        expect(described_class.new(attributes).email).to eq(nil)
      end

      it 'accepts empty phone' do
        attributes.reject! { |k,v| k == :phone }
        expect(described_class.new(attributes).phone).to eq(nil)
      end

      it 'accepts empty address' do
        attributes.reject! { |k,v| k == :address }
        expect(described_class.new(attributes).address).to eq(nil)
      end
    end
  end
end
