require 'paymongo/api/v1/payment_method/create'
require 'paymongo/api/v1/payment_method/retrieve'

module Paymongo
  module Api
    module V1
      module PaymentMethod
        class Resource
          extend PaymentMethod::Create
          extend PaymentMethod::Retrieve
        end
      end
    end
  end
end