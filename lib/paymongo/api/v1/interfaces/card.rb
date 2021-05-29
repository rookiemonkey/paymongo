module Paymongo
  module Api
    module V1
      module Interfaces
        class Card
          attr_reader :card_number, :exp_month, :exp_year, :cvc

          def initialize(attributes)
            validate_data_types(attributes)
            @card_number = attributes[:card_number]
            @exp_month = attributes[:exp_month]
            @exp_year = attributes[:exp_year]
            @cvc = attributes[:cvc]
          end

          private

          def validate_data_types(attributes)
            unless attributes.keys.all? { |key| attributes[key].is_a?(data_types[key])  }
              raise PaymongoError.new('Invalid Card Detail. Please check the required data types')
            end
          end

          def data_types
            {
              card_number: String,
              exp_month: Integer,
              exp_year: Integer,
              cvc: String
            }
          end
        end
      end
    end
  end
end