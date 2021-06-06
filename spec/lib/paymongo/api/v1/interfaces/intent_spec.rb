require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::Interfaces::Intent do
    let(:attributes) do
      {
        amount: 1000,
        payment_method_allowed: ['card'],
        payment_method_options: {
          card: {
            request_three_d_secure: 'any'
          }
        },
        description: 'Test Description',
        statement_descriptor: 'Test Descriptor',
        currency: 'PHP',
        metadata: {
          note1: 'This is just a test',
          note2: 'I love XRP'
        }
      }
    end

    describe 'Valid Payment Intent' do
      let(:payment_intent) { described_class.new(attributes) }

      it 'is an instance of Interfaces::Intent' do
        expect(payment_intent.class).to eq(described_class)
      end

      it 'has amount and its an Integer' do
        expect(payment_intent.respond_to?('amount')).to eq(true)
        expect(payment_intent.amount).to eq(attributes[:amount])
        expect(payment_intent.amount.class).to eq(Integer)
      end

      it 'has payment_method_allowed and its an Array' do 
        expect(payment_intent.respond_to?('payment_method_allowed')).to eq(true)
        expect(payment_intent.payment_method_allowed).to eq(attributes[:payment_method_allowed])
        expect(payment_intent.payment_method_allowed.class).to eq(Array)
      end

      it 'has payment_method_options and its a Hash' do 
        expect(payment_intent.respond_to?('payment_method_options')).to eq(true)
        expect(payment_intent.payment_method_options).to eq(attributes[:payment_method_options])
        expect(payment_intent.payment_method_options.class).to eq(Hash)
      end

      it 'has description and its a String' do 
        expect(payment_intent.respond_to?('description')).to eq(true)
        expect(payment_intent.description).to eq(attributes[:description])
        expect(payment_intent.description.class).to eq(String)
      end

      it 'has statement_descriptor and its a String' do 
        expect(payment_intent.respond_to?('statement_descriptor')).to eq(true)
        expect(payment_intent.statement_descriptor).to eq(attributes[:statement_descriptor])
        expect(payment_intent.statement_descriptor.class).to eq(String)
      end

      it 'has currency and its a String' do 
        expect(payment_intent.respond_to?('currency')).to eq(true)
        expect(payment_intent.currency).to eq(attributes[:currency])
        expect(payment_intent.currency.class).to eq(String)
      end

      it 'has metadata and its a String' do 
        expect(payment_intent.respond_to?('metadata')).to eq(true)
        expect(payment_intent.metadata).to eq(attributes[:metadata])
        expect(payment_intent.metadata.class).to eq(Hash)
      end
    end

    describe 'Valid Payment Intent Nullable' do
      it 'accepts empty payment_method_options' do
        attributes.reject! { |k,v| k == :payment_method_options }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty payment_method_options' do
        attributes.reject! { |k,v| k == :payment_method_options }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty description' do
        attributes.reject! { |k,v| k == :description }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty statement_descriptor' do
        attributes.reject! { |k,v| k == :statement_descriptor }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty metadata' do
        attributes.reject! { |k,v| k == :metadata }
        expect { described_class.new(attributes) }.not_to raise_error
      end
    end

    describe 'Invalid Payment Intent Wrong Data Types' do
      it 'only accepts amount as an Integer' do
        attributes[:amount] = '1000'
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts payment_method_allowed as an Array' do
        attributes[:payment_method_allowed] = { card: 'card' }
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts payment_method_allowed as an Array of Strings' do
        attributes[:payment_method_allowed] = [2]
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts payment_method_options as a Hash' do
        attributes[:payment_method_options] = [2]
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts description as a String' do
        attributes[:description] = 1
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts statement_descriptor as a String' do
        attributes[:statement_descriptor] = 1
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts currency as a String' do
        attributes[:currency] = 1
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts metadata as a Hash' do
        attributes[:metadata] = 1
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end
    end

    describe 'Invalid Payment Intent Required Fields' do
      it 'doesnt accept w/o an amount' do
        attributes.reject! { |k,v| k == :amount }
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'doesnt accept w/o a payment_method_allowed' do
        attributes.reject! { |k,v| k == :payment_method_allowed }
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end
    end

    describe '.to_hash' do
      let(:payment_intent) { described_class.new(attributes) }

      it 'returns a hash' do
        expect(payment_intent.to_hash.class).to eq(ActiveSupport::HashWithIndifferentAccess)
      end

      it 'can be accessed thru string' do
        expect(payment_intent.to_hash['amount']).to eq(attributes[:amount])
      end

      it 'can be accessed thru symbol' do
        expect(payment_intent.to_hash[:amount]).to eq(attributes[:amount])
      end
    end

    describe '.as_request_body' do
      let(:payment_intent) { described_class.new(attributes) }

      it 'returns a string' do
        expect(payment_intent.as_request_body.class).to eq(String)
      end

      it 'returns a json version of its attributes' do
        expect(JSON.parse(payment_intent.as_request_body)).to eq({ 'data' => { 'attributes' => payment_intent.to_hash } })
      end
    end
  end
end
