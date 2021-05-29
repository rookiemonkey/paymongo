require 'paymongo/api/v1/tokens/create'
require 'paymongo/api/v1/tokens/retrieve'

module Paymongo
  module Api
    module V1
      module Tokens
        class Resource
          extend Tokens::Create
          extend Tokens::Retrieve
        end
      end
    end
  end
end