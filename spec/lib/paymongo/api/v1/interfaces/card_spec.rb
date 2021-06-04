require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::Interfaces::Card do
    let(:attributes) { { card_number: '1234567812345678', exp_month: 12, exp_year: 2050, cvc: '123' } }

    describe 'Valid Card' do
      let(:card) { described_class.new(attributes) }
      
      it 'is an instance of Interfaces::Card' do
        expect(card.class).to eq(described_class)
      end

      it 'has card_number and its a string' do
        expect(card.respond_to?('card_number')).to eq(true)
        expect(card.card_number).to eq(attributes[:card_number])
        expect(card.card_number.class).to eq(String)
      end

      it 'has exp_month and its an integer' do
        expect(card.respond_to?('exp_month')).to eq(true)
        expect(card.exp_month).to eq(attributes[:exp_month])
        expect(card.exp_month.class).to eq(Integer)
      end

      it 'has exp_year and its an integer' do
        expect(card.respond_to?('exp_year')).to eq(true)
        expect(card.exp_year).to eq(attributes[:exp_year])
        expect(card.exp_year.class).to eq(Integer)
      end

      it 'has cvc and its a string' do
        expect(card.respond_to?('cvc')).to eq(true)
        expect(card.cvc).to eq(attributes[:cvc])
        expect(card.cvc.class).to eq(String)
      end
    end

    describe 'Invalid Card' do
      it 'raise PaymongoError for card_number that is not a String' do
        attributes[:card_number] = attributes[:card_number].to_i
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for exp_month that is not an Integer' do
        attributes[:exp_month] = attributes[:exp_month].to_s
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for exp_year that is not an Integer' do
        attributes[:exp_year] = attributes[:exp_year].to_s
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end

      it 'raise PaymongoError for cvc that is not a String' do
        attributes[:cvc] = attributes[:cvc].to_i
        expect { described_class.new(attributes) }.to raise_error(PaymongoError)
      end
    end

    describe '.to_hash' do
      let(:card) { described_class.new(attributes) }

      it 'returns a hash' do
        expect(card.to_hash.class).to eq(ActiveSupport::HashWithIndifferentAccess)
      end

      it 'can be accessed thru string' do
        expect(card.to_hash['card_number']).to eq(attributes[:card_number])
      end

      it 'can be accessed thru symbol' do
        expect(card.to_hash[:card_number]).to eq(attributes[:card_number])
      end
    end

    describe '.as_request_body' do
      let(:card) { described_class.new(attributes) }

      it 'returns a string' do
        expect(card.as_request_body.class).to eq(String)
      end

      it 'returns a json version of its attributes' do
        expect(JSON.parse(card.as_request_body)).to eq({ 'data' => { 'attributes' => card.to_hash } })
      end
    end
  end
end
