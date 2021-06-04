require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::PaymentMethodRecord do
    let(:payment_method) do
      Paymongo::Api::V1::PaymentMethodRecord.new({
        details:{ 
          card_number: '4343434343434345', 
          exp_month: 12, 
          exp_year: 2050, 
          cvc: '123' 
        },
        billing:  { 
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
        },
        metadata: {
          note1: 'This is just a test',
          note2: 'I love XRP'
        }
      })
    end

    before do
      Paymongo.configure do |c|
        c.secret_key = CONFIG[:secret_key]
        c.public_key = CONFIG[:public_key]
      end
    end

    describe 'class variables' do
      it 'has base_url pointing to payment method route' do
        expect(described_class.base_url).to eq("#{Paymongo::Api::V1::Config.base_url}/payment_methods")
      end
    end

    describe '.create' do
      it 'responds to create method' do
        expect(described_class.respond_to?('create')).to eq(true)
      end

      it 'only takes in an instance of Paymongo::Api::V1::PaymentMethod::Resource' do
        expect{ described_class.create('ordinary-string') }.to raise_error(PaymongoError)
      end

      it 'creates a payment method', { vcr: { record: :once, match_requests_on: %i[method] } } do
        expect(described_class.create(payment_method)).to eq(cassette_response('Paymongo_Api_V1_PaymentMethodRecord/_create/creates_a_payment_method.yml'))
      end
    end

    describe '.retrieve' do
      it 'responds to retrieve method' do
        expect(described_class.respond_to?('retrieve')).to eq(true)
      end

      it 'returns the payment method from Paymongo API', { vcr: { record: :once, match_requests_on: %i[method] } } do
        payment_method = cassette_response('Paymongo_Api_V1_PaymentMethodRecord/_create/creates_a_payment_method.yml')
        expect(described_class.retrieve(payment_method['data']['id'])).to eq(payment_method)
      end
    end
  end
end