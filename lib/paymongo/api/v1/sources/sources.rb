require 'paymongo/api/v1/sources/create'
require 'paymongo/api/v1/sources/retrieve'

module Paymongo
  module Api
    module V1
      module Sources
        class Resource
          extend Sources::Create
          extend Sources::Retrieve
        end
      end
    end
  end
end