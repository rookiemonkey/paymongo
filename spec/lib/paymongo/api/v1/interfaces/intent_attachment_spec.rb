require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::Interfaces::IntentAttachment do
    let(:attributes) do
      {
        payment_method: 'pm_HzKNebHUub3yT4JTadLDY1Hy',
        client_key: 'pi_mFVmCm1xVzqgfv3S5A5KzVWV_client_Kny1Jx9tcpMqu8C34pHvCMnW',
        return_url: 'https://www.google.com/'
      }
    end

    describe 'Valid Payment Intent Attachment' do
      let(:payment_intent_attachment) { described_class.new(attributes) }

      it 'is an instance of Interfaces::IntentAttachment' do
        expect(payment_intent_attachment.class).to eq(described_class)
      end

      it 'has payment_method and its a String' do
        expect(payment_intent_attachment.respond_to?('payment_method')).to eq(true)
        expect(payment_intent_attachment.payment_method).to eq(attributes[:payment_method])
        expect(payment_intent_attachment.payment_method.class).to eq(String)
      end

      it 'has client_key and its a String' do
        expect(payment_intent_attachment.respond_to?('client_key')).to eq(true)
        expect(payment_intent_attachment.client_key).to eq(attributes[:client_key])
        expect(payment_intent_attachment.client_key.class).to eq(String)
      end

      it 'has return_url and its a String' do
        expect(payment_intent_attachment.respond_to?('return_url')).to eq(true)
        expect(payment_intent_attachment.return_url).to eq(attributes[:return_url])
        expect(payment_intent_attachment.return_url.class).to eq(String)
      end
    end

    describe 'Valid Payment Intent Attachment Nullable Fields' do
      it 'accepts empty client_key' do
        attributes.reject! { |k,v| k == :client_key }
        expect { described_class.new(attributes) }.not_to raise_error
      end

      it 'accepts empty return_url' do
        attributes.reject! { |k,v| k == :return_url }
        expect { described_class.new(attributes) }.not_to raise_error
      end
    end

    describe 'Invalid Payment Intent Wrong Data Types' do
      it 'only accepts payment_method as a String' do
        attributes[:payment_method] = ['payment-method-id']
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts client_key as a String' do
        attributes[:client_key] = ['client-key']
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'only accepts return_url as a String' do
        attributes[:return_url] = ['return-url']
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end
    end

    describe 'Invalid Payment Intent Attachment Required Fields' do
      it 'doesnt accept w/o a payment_method' do
        attributes.reject! { |k,v| k == :payment_method }
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
