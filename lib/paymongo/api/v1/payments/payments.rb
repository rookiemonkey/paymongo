require 'paymongo/api/v1/payments/create'
require 'paymongo/api/v1/payments/retrieve'
require 'paymongo/api/v1/payments/list'

module Paymongo
  module Api
    module V1
      module Payments
        class Resource
          extend Payments::Create
          extend Payments::Retrieve
          extend Payments::List
        end
      end
    end
  end
end