require 'paymongo/api/v1/payment_method/create'
require 'paymongo/api/v1/payment_method/retrieve'

module Paymongo
  module Api
    module V1
      module PaymentMethod
        class Resource
          include BaseModule
          attr_reader :type, :details, :billing, :metadata

          def initialize(attributes)
            @type = 'card'
            @details = attributes[:details]
            @billing = attributes[:billing]
            @metadata = attributes[:metadata]
          end

          def as_http_parameter
            JSON.generate({
              data: {
                attributes: {
                  type: @type,
                  details: @details,
                  billing: @billing,
                  metadata: @metadata
                }
              }
            })
          end

          def self.base_url
            "#{Paymongo::Api::V1::Config.base_url}/payment_methods"
          end

          extend PaymentMethod::Create
          extend PaymentMethod::Retrieve
        end
      end
    end
  end
end