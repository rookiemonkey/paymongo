require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::PaymentIntentRecord do
    let(:payment_intent) do
      described_class.new({
        amount: 10000,
        payment_method_allowed: ['card'],
        payment_method_options: {
          card: {
            request_three_d_secure: 'any'
          }
        },
        description: 'Test Description',
        statement_descriptor: 'Test Statement Descriptor',
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
      it 'has base_url pointing to payment intent route' do
        expect(described_class.base_url).to eq("#{Paymongo::Api::V1::Config.base_url}/payment_intents")
      end
    end

    describe 'instance variables' do
      it 'has amount instance variable' do
        expect(payment_intent.respond_to?('amount')).to eq(true)
      end

      it 'has payment_method_allowed instance variable' do
        expect(payment_intent.respond_to?('payment_method_allowed')).to eq(true)
      end

      it 'has payment_method_options instance variable' do
        expect(payment_intent.respond_to?('payment_method_options')).to eq(true)
      end

      it 'has currency instance variable' do
        expect(payment_intent.respond_to?('currency')).to eq(true)
      end

      it 'has description instance variable' do
        expect(payment_intent.respond_to?('description')).to eq(true)
      end

      it 'has statement_descriptor instance variable' do
        expect(payment_intent.respond_to?('statement_descriptor')).to eq(true)
      end

      it 'has metadata instance variable' do
        expect(payment_intent.respond_to?('metadata')).to eq(true)
      end
    end

    describe '.create' do
      it 'responds to create method' do
        expect(described_class.respond_to?('create')).to eq(true)
      end

      it 'only takes in an instance of Paymongo::Api::V1::PaymentIntent::Resource' do
        expect{ described_class.create('ordinary-string') }.to raise_error(PaymongoError)
      end

      it 'creates a payment intent', { vcr: { record: :once, match_requests_on: %i[method] } } do
        expect(described_class.create(payment_intent)).to eq(cassette_response('Paymongo_Api_V1_PaymentIntentRecord/_create/creates_a_payment_intent.yml'))
      end
    end

    describe '.retrieve' do
      let(:response) { cassette_response('Paymongo_Api_V1_PaymentIntentRecord/_create/creates_a_payment_intent.yml') }

      it 'responds to retrieve_payment_intent method' do
        expect(described_class.respond_to?('retrieve')).to eq(true)
      end

      it 'returns the payment intent from Paymongo API', { vcr: { record: :once, match_requests_on: %i[method] } } do
        payment_intent_id = response['data']['id']
        client_key = response['data']['attributes']['client_key']
        expect(described_class.retrieve(payment_intent_id, client_key)).to eq(response)
      end
    end

    describe '.attach' do
      it 'only takes in an instance of Paymongo::Api::V1::Interfaces::IntentAttachment' do
        expect{ described_class.attach('sample-payment-id', {}) }.to raise_error(PaymongoError)
      end

      it 'returns details of the attachment', { vcr: { record: :once, match_requests_on: %i[method] } } do

        # create payment method
        new_payment_method = Paymongo::Api::V1::PaymentMethodRecord.create(
          Paymongo::Api::V1::PaymentMethodRecord.new({
            details:{ 
              card_number: '4343434343434345', 
              exp_month: 12, 
              exp_year: 2050, 
              cvc: '123' 
            }
          })
        )

        # create payment intent
        new_payment_intent = described_class.create(described_class.new(payment_intent.to_hash))
        client_key = new_payment_intent['data']['attributes']['client_key']
        payment_intent_id = new_payment_intent['data']['id']

        # create payment attachment
        payment_intent_attachment = Paymongo::Api::V1::Interfaces::IntentAttachment.new({
          payment_method: new_payment_method['data']['id'],
          client_key: client_key,
          return_url: 'https://www.google.com/'
        })

        expect(described_class.attach(payment_intent_id, payment_intent_attachment)).to eq(cassette_response('Paymongo_Api_V1_PaymentIntentRecord/_attach/returns_details_of_the_attachment.yml', 3) )
      end
    end
  end
end