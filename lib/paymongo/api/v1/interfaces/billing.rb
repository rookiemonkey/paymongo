module Paymongo
  module Api
    module V1
      module Interfaces
        class Billing
          include Paymongo::Api::V1::Hashable
          attr_reader :name, :email, :phone, :address

          def initialize(attributes = {})
            validate_data_types(attributes)
            @name = attributes[:name]
            @email = attributes[:email]
            @phone = attributes[:phone]
            @address = attributes[:address] ? Interfaces::Address.new(attributes[:address]) : nil
          end

          private

          def validate_data_types(attributes)
            unless attributes.keys.all? { |key| attributes[key].is_a?(data_types[key])  }
              raise PaymongoError.new('Invalid Billing. Please check the required data types')
            end
          end

          def data_types
            {
              name: String,
              email: String,
              phone: String,
              address: Hash
            }.with_indifferent_access
          end
        end
      end
    end
  end
end