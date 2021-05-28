require 'paymongo/gateway/payment_intent/create'
require 'paymongo/gateway/payment_intent/retrieve'
require 'paymongo/gateway/payment_intent/attach'
require 'paymongo/gateway/payment_method/create'
require 'paymongo/gateway/payment_method/retrieve'
require 'paymongo/gateway/sources/create'
require 'paymongo/gateway/sources/retrieve'
require 'paymongo/gateway/payments/create'

module Paymongo
  class TransactionGateway

    def initialize(gateway)
      @gateway = gateway
      @config = gateway.config
      @config.assert_has_keys
      self.extend_api_methods
    end

    def sale(attributes)
      # Wrap the hash
      create(
        {
          data: {
            attributes: {
              amount: attributes[:amount],
              currency: attributes[:currency],
              description: attributes[:description],
              statement_descriptor: attributes[:statement_descriptor],
              source: { id: attributes[:token], type: 'token' }
            }
          }
        }
      )
    end

    def create(attributes)
      _do_create '/payments', transaction: attributes
    end

    def _do_create(path, params = nil)
      response = @config.https.post("#{@config.base_url}#{path}", params)
      _handle_transaction_response(response)
    end

    def _handle_transaction_response(response)
      if response[:data]
        SuccessfulResult.new(
          transaction: Transaction._new(@gateway, response[:data])
        )
      elsif response[:errors]
        ErrorResult.new(@gateway, response[:errors])
      else
        raise UnexpectedError, 'expected :data'
      end
    end

    private

    def extend_api_methods
      self.extend(PaymentIntent::Create)
      self.extend(PaymentIntent::Retrieve)
      self.extend(PaymentIntent::Attach)
      self.extend(PaymentMethod::Create)
      self.extend(PaymentMethod::Retrieve)
      self.extend(Sources::Create)
      self.extend(Sources::Retrieve)
      self.extend(Payments::Create)
    end
  end
end
