module Paymongo
  module Api
    module V1
      module Interfaces
        class Card
          include Paymongo::Api::V1::Hashable
          attr_reader :card_number, :exp_month, :exp_year, :cvc

          REQUIRED_ATTRIBUTES = %i[card_number exp_month exp_year cvc]

          def initialize(attributes)
            validate_required_attributes(attributes)
            validate_data_types(attributes)
            @card_number = attributes[:card_number]
            @exp_month = attributes[:exp_month]
            @exp_year = attributes[:exp_year]
            @cvc = attributes[:cvc]
          end

          private
          
          def validate_required_attributes(attributes)
            missing_attributes = REQUIRED_ATTRIBUTES - attributes.keys.map(&:to_sym)
            raise PaymongoError.new("Invalid Card Details. Missing this attributes: #{missing_attributes.to_s}") unless missing_attributes.size.zero?
          end

          def validate_data_types(attributes)
            unless attributes.keys.all? { |key| attributes[key].is_a?(data_types[key])  }
              raise PaymongoError.new('Invalid Card Details. Please check the required data types')
            end
          end

          def data_types
            {
              card_number: String,
              exp_month: Integer,
              exp_year: Integer,
              cvc: String
            }.with_indifferent_access
          end
        end
      end
    end
  end
end