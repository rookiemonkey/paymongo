require 'paymongo/api/v1/webhooks/create'
require 'paymongo/api/v1/webhooks/enable'
require 'paymongo/api/v1/webhooks/disable'
require 'paymongo/api/v1/webhooks/list'
require 'paymongo/api/v1/webhooks/retrieve'
require 'paymongo/api/v1/webhooks/update'

module Paymongo
  module Api
    module V1
      module Webhooks
        class Resource
          extend Webhooks::Create
          extend Webhooks::Enable
          extend Webhooks::Disable
          extend Webhooks::List
          extend Webhooks::Retrieve
          extend Webhooks::Update
        end
      end
    end
  end
end