require 'spec_helper'

module Paymongo
  RSpec.describe Api::V1::WebhookRecord do
    describe '.create_webhook' do
      it 'responds to create_webhook method' do
        expect(described_class.respond_to?('create_webhook')).to eq(true)
      end
    end

    describe '.disable_webhook' do
      it 'responds to disable_webhook method' do
        expect(described_class.respond_to?('disable_webhook')).to eq(true)
      end
    end

    describe '.enable_webhook' do
      it 'responds to enable_webhook method' do
        expect(described_class.respond_to?('enable_webhook')).to eq(true)
      end
    end

    describe '.list_all_webhooks' do
      it 'responds to list_all_webhooks method' do
        expect(described_class.respond_to?('list_all_webhooks')).to eq(true)
      end
    end

    describe '.retrieve_webhook' do
      it 'responds to retrieve_webhook method' do
        expect(described_class.respond_to?('retrieve_webhook')).to eq(true)
      end
    end

    describe '.update_webhook' do
      it 'responds to update_webhook method' do
        expect(described_class.respond_to?('update_webhook')).to eq(true)
      end
    end
  end
end