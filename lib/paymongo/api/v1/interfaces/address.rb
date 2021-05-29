module Paymongo
  module Api
    module V1
      module Interfaces
        class Address
          attr_reader :line1, :line2, :city, :state, :postal_code, :country

          def initialize(attributes = {})
            validate_data_types(attributes)
            @line1 = attributes[:line1] || nil
            @line2 = attributes[:line2] || nil
            @city = attributes[:city] || nil
            @state = attributes[:state] || nil
            @postal_code = attributes[:postal_code] || nil
            @country = attributes[:country] || nil
          end

          private

          def validate_data_types(attributes)
            unless attributes.keys.all? { |key| attributes[key].is_a?(data_types[key])  }
              raise PaymongoError.new('Invalid Address. Please check the required data types')
            end
          end

          def data_types
            {
              line1: String,
              line2: String,
              city: String,
              state: String,
              postal_code: String,
              country: String
            }
          end
        end
      end
    end
  end
end