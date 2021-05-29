module Paymongo
  module Api
    module V1
      class PaymentIntentRecord < PaymentIntent::Resource; end
      class PaymentMethodRecord < PaymentMethod::Resource; end
      class PaymentRecord < Payments::Resource; end
      class SourceRecord < Sources::Resource; end
      class TokenRecord < Tokens::Resource; end
      class WebhookRecord < Webhooks::Resource; end
    end
  end
end