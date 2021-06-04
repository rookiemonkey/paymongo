require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::Interfaces::Address do
    let(:attributes) do
      { 
        line1: 'Blk1 Lot2 Maginhawa St.', 
        line2: 'Brgy. Iniwan', 
        city: 'Quezon City', 
        state: 'NCR',
        postal_code: '1117',
        country: 'PH'
      }
    end

    describe 'Valid Address' do
      let(:address) { described_class.new(attributes) }
      
      it 'is an instance of Interfaces::Address' do
        expect(address.class).to eq(described_class)
      end

      it 'has line1 and its a string' do
        expect(address.respond_to?('line1')).to eq(true)
        expect(address.line1).to eq(attributes[:line1])
        expect(address.line1.class).to eq(String)
      end

      it 'has line2 and its a string' do
        expect(address.respond_to?('line2')).to eq(true)
        expect(address.line2).to eq(attributes[:line2])
        expect(address.line2.class).to eq(String)
      end

      it 'has city and its a string' do
        expect(address.respond_to?('city')).to eq(true)
        expect(address.city).to eq(attributes[:city])
        expect(address.city.class).to eq(String)
      end

      it 'has state and its a string' do
        expect(address.respond_to?('state')).to eq(true)
        expect(address.state).to eq(attributes[:state])
        expect(address.state.class).to eq(String)
      end

      it 'has postal_code and its a string' do
        expect(address.respond_to?('postal_code')).to eq(true)
        expect(address.postal_code).to eq(attributes[:postal_code])
        expect(address.postal_code.class).to eq(String)
      end

      it 'has country and its a string' do
        expect(address.respond_to?('country')).to eq(true)
        expect(address.country).to eq(attributes[:country])
        expect(address.country.class).to eq(String)
      end
    end

    describe 'Valid Address Nullable' do
      it 'accepts empty line1' do
        attributes.reject! { |k,v| k == :line1 }
        expect(described_class.new(attributes).line1).to eq(nil)
      end

      it 'accepts empty line2' do
        attributes.reject! { |k,v| k == :line2 }
        expect(described_class.new(attributes).line2).to eq(nil)
      end

      it 'accepts empty city' do
        attributes.reject! { |k,v| k == :city }
        expect(described_class.new(attributes).city).to eq(nil)
      end

      it 'accepts empty state' do
        attributes.reject! { |k,v| k == :state }
        expect(described_class.new(attributes).state).to eq(nil)
      end

      it 'accepts empty postal_code' do
        attributes.reject! { |k,v| k == :postal_code }
        expect(described_class.new(attributes).postal_code).to eq(nil)
      end

      it 'accepts empty country' do
        attributes.reject! { |k,v| k == :country }
        expect(described_class.new(attributes).country).to eq(nil)
      end
    end

    describe 'Invalid Card' do
      it 'raise PaymongoError for line1 that is not a String' do
        attributes[:line1] = 999
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for line2 that is not a String' do
        attributes[:line2] = 999
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for city that is not a String' do
        attributes[:city] = 999
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for state that is not a String' do
        attributes[:state] = 999
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for postal_code that is not a String' do
        attributes[:postal_code] = 999
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for country that is not a String' do
        attributes[:country] = 999
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end
    end

    describe '.to_hash' do
      let(:address) { described_class.new(attributes) }

      it 'returns a hash' do
        expect(address.to_hash.class).to eq(ActiveSupport::HashWithIndifferentAccess)
      end

      it 'can be accessed thru string' do
        expect(address.to_hash['line1']).to eq(attributes[:line1])
      end

      it 'can be accessed thru symbol' do
        expect(address.to_hash[:line1]).to eq(attributes[:line1])
      end
    end

    describe '.as_request_body' do
      let(:address) { described_class.new(attributes) }

      it 'returns a string' do
        expect(address.as_request_body.class).to eq(String)
      end

      it 'returns a json version of its attributes' do
        expect(JSON.parse(address.as_request_body)).to eq({ 'data' => { 'attributes' => address.to_hash } })
      end
    end
  end
end
