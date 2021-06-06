module Paymongo
  module Api
    module V1
      module Interfaces
        class Intent
          include Paymongo::Api::V1::Hashable
          attr_reader :amount, :payment_method_allowed, :payment_method_options, :currency,
                      :description, :statement_descriptor, :metadata

          REQUIRED_ATTRIBUTES = %i[amount payment_method_allowed]

          def initialize(attributes = {})
            validate_required_attributes(attributes)
            validate_data_types(attributes)
            @amount = attributes[:amount]
            @payment_method_allowed = attributes[:payment_method_allowed]
            @payment_method_options = attributes[:payment_method_options]
            @currency = 'PHP'
            @description = attributes[:description]
            @statement_descriptor = attributes[:statement_descriptor]
            @metadata = attributes[:metadata]
          end

          private

          def validate_required_attributes(attributes)
            missing_attributes = REQUIRED_ATTRIBUTES - attributes.keys.map(&:to_sym)
            raise PaymongoError.new("Invalid Payment Intent. Missing this attributes: #{missing_attributes.to_s}") unless missing_attributes.size.zero?
          end

          def validate_data_types(attributes)
            valid_data_types = attributes.keys.all? do |key|
              case key
              when :payment_method_allowed
                (attributes[key].is_a?(data_types[key]) && attributes[key].all? { |i| i.is_a?(String) })

              when :payment_method_options
                next unless attributes[key].is_a?(data_types[key])
                payment_method_options = attributes[key].keys
                card = attributes[key][:card]
                card_keys = card.keys

                (attributes[key].is_a?(data_types[key]) && payment_method_options.size == 1 && payment_method_options.first == :card && card.is_a?(Hash) && card_keys.size == 1 && card_keys.first == :request_three_d_secure && card[:request_three_d_secure].is_a?(String))
              else
                
                attributes[key].is_a?(data_types[key])
              end
            end

            unless valid_data_types
              raise PaymongoError.new('Invalid Payment Intent. Please check the required data types')
            end
          end

          def data_types
            {
              amount: Integer,
              payment_method_allowed: Array,
              payment_method_options: Hash,
              description: String,
              statement_descriptor: String,
              currency: String,
              metadata: Hash
            }.with_indifferent_access
          end
        end
      end
    end
  end
end