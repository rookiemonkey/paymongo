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

      it 'billing address is an intance of Interfaces::Address' do
        expect(billing.address.class).to eq(Paymongo::Api::V1::Interfaces::Address)
      end

      # for all interfaces
      # add check for the necessary fields only
      # for Billing spec, add the check ofr the attributes
    end
  end
end
