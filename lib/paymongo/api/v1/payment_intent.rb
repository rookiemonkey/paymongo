module Paymongo
  module Api
    module V1
      module PaymentIntent
        class Resource < Paymongo::Api::V1::Interfaces::Intent
          include Paymongo::Api::V1::Hashable

          def initialize(attributes)
            super(attributes)
          end

          def self.base_url
            "#{Config.base_url}/payment_intents"
          end

          def self.create(resource)
            raise PaymongoError.new('Not a PaymentIntent instance') unless resource.is_a?(PaymentIntent::Resource)
            Paymongo::Api::V1::Https.post(base_url, resource.as_request_body)
          end

          def self.retrieve(payment_intent_id, client_key)
            Paymongo::Api::V1::Https.get("#{base_url}/#{payment_intent_id}?client_key=#{client_key}")
          end

          def self.attach(payment_intent_id, resource)
            raise PaymongoError.new('Not a PaymentIntent Attachment instance') unless resource.is_a?(Paymongo::Api::V1::Interfaces::IntentAttachment)
            Paymongo::Api::V1::Https.post("#{base_url}/#{payment_intent_id}/attach", resource.as_request_body)
          end
        end
      end
    end
  end
end