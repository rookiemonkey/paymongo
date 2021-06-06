module Paymongo
  module Api
    module V1
      module Interfaces
        class IntentAttachment
          include Paymongo::Api::V1::Hashable
          attr_reader :payment_method, :client_key, :return_url

          REQUIRED_ATTRIBUTES = %i[payment_method]

          def initialize(attributes = {})
            validate_required_attributes(attributes)
            validate_data_types(attributes)
            @payment_method = attributes[:payment_method]
            @client_key = attributes[:client_key]
            @return_url = attributes[:return_url]
          end

          private

          def validate_required_attributes(attributes)
            missing_attributes = REQUIRED_ATTRIBUTES - attributes.keys
            raise PaymongoError.new("Invalid Payment Intent. Missing this attributes: #{missing_attributes.to_s}") unless missing_attributes.size.zero?
          end

          def validate_data_types(attributes)
            unless attributes.keys.all? { |key| attributes[key].is_a?(data_types[key])  }
              raise PaymongoError.new('Invalid Payment Intent Attachment. Please check the required data types')
            end
          end

          def data_types
            {
              payment_method: String,
              client_key: String,
              return_url: String
            }.with_indifferent_access
          end
        end
      end
    end
  end
end