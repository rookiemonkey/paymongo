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

    describe 'Valid Billing Nullable' do
      it 'accepts empty name' do
        attributes.reject! { |k,v| k == :name }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty email' do
        attributes.reject! { |k,v| k == :email }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty phone' do
        attributes.reject! { |k,v| k == :phone }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty address' do
        attributes.reject! { |k,v| k == :address }
        expect { described_class.new(attributes) }.not_to raise_error
      end
    end

    describe 'Valid Billing Nullable' do
      it 'accepts empty name' do
        attributes.reject! { |k,v| k == :name }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty email' do
        attributes.reject! { |k,v| k == :email }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty phone' do
        attributes.reject! { |k,v| k == :phone }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty address' do
        attributes.reject! { |k,v| k == :address }
        expect { described_class.new(attributes) }.not_to raise_error
      end
    end

    describe '.to_hash' do
      let(:billing) { described_class.new(attributes) }

      it 'returns a hash' do
        expect(billing.to_hash.class).to eq(ActiveSupport::HashWithIndifferentAccess)
      end

      it 'can be accessed thru string' do
        expect(billing.to_hash['name']).to eq(attributes[:name])
      end

      it 'can be accessed thru symbol' do
        expect(billing.to_hash[:name]).to eq(attributes[:name])
      end
    end

    describe '.as_request_body' do
      let(:billing) { described_class.new(attributes) }

      it 'returns a string' do
        expect(billing.as_request_body.class).to eq(String)
      end

      it 'returns a json version of its attributes' do
        expect(JSON.parse(billing.as_request_body)).to eq({ 'data' => { 'attributes' => billing.to_hash } })
      end
    end
  end
end
