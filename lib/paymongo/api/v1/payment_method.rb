module Paymongo
  module Api
    module V1
      module PaymentMethod
        class Resource
          include Paymongo::Api::V1::Hashable
          attr_reader :type, :details, :billing, :metadata

          def initialize(attributes = {})
            @type = 'card'
            @details = attributes[:details] ? Interfaces::Card.new(attributes[:details]) : nil
            @billing = attributes[:billing] ? Interfaces::Billing.new(attributes[:billing]) : nil
            @metadata = attributes[:metadata] || nil
          end

          def self.base_url
            "#{Config.base_url}/payment_methods"
          end

          def self.create(resource)
            raise PaymongoError.new('Not a PaymentMethod instance') unless resource.is_a?(PaymentMethod::Resource)
            Paymongo::Api::V1::Https.post(base_url, resource.as_request_body)
          end

          def self.retrieve(resource)
            Paymongo::Api::V1::Https.get("#{base_url}/#{resource}")
          end
        end
      end
    end
  end
end