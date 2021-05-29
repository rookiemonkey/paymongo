require 'paymongo/api/v1/interfaces/card'
require 'paymongo/api/v1/interfaces/address'
require 'paymongo/api/v1/interfaces/billing'

module Paymongo
  module Api
    module V1
      module Config
        def self.base_url
          'https://api.paymongo.com/v1'
        end
      end
    end
  end
end