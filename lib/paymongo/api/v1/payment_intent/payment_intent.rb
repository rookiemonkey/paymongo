require 'paymongo/api/v1/payment_intent/create'
require 'paymongo/api/v1/payment_intent/retrieve'
require 'paymongo/api/v1/payment_intent/attach'

module Paymongo
  module Api
    module V1
      module PaymentIntent
        class Resource
          extend PaymentIntent::Create
          extend PaymentIntent::Retrieve
          extend PaymentIntent::Attach
        end
      end
    end
  end
end