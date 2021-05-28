require 'gem_config'
require 'paymongo/version'
require 'net/http'
require 'net/https'
require 'json'
require 'paymongo/base_module'
require 'paymongo/gateway'
require 'paymongo/configuration'
require 'paymongo/exceptions'
require 'paymongo/transaction_gateway'
require 'paymongo/transaction'
require 'paymongo/http'
require 'paymongo/successful_result'
require 'paymongo/error_result'
require 'paymongo/v1/payment_intent/create'
require 'paymongo/v1/payment_intent/retrieve'
require 'paymongo/v1/payment_intent/attach'
require 'paymongo/v1/payment_method/create'
require 'paymongo/v1/payment_method/retrieve'
require 'paymongo/v1/sources/create'
require 'paymongo/v1/sources/retrieve'
require 'paymongo/v1/payments/create'
require 'paymongo/v1/payments/list'
require 'paymongo/v1/payments/retrieve'
require 'paymongo/v1/tokens/create'
require 'paymongo/v1/tokens/retrieve'
require 'paymongo/v1/webhooks/create'
require 'paymongo/v1/webhooks/disable'
require 'paymongo/v1/webhooks/enable'
require 'paymongo/v1/webhooks/list'
require 'paymongo/v1/webhooks/retrieve'
require 'paymongo/v1/webhooks/update'

module Paymongo
  include GemConfig::Base

  with_configuration do
    has :secret_key, classes: String
    has :public_key, classes: String
    has :logger
  end
end
