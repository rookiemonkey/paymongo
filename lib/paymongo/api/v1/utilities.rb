module Paymongo
  module Api
    module V1
      module Https
        def self.post(path, params = { transaction: nil })
          Paymongo::Gateway.new(Paymongo::Configuration.new).config.https.post(path, params)
        end

        def self.get(path, params = nil)
          header = { 'Content-Type': 'application/json' }
          uri = URI.parse(path)
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          req = Net::HTTP::Get.new(uri.path, header)
          req.basic_auth(Paymongo.configuration.secret_key, '')
          res = https.request(req)
          JSON.parse(res.body).with_indifferent_access
        end
      end

      module Hashable
        def to_hash
          self.instance_variables.inject({}) do |hash_result, instance_variable|
            key = instance_variable[1..instance_variable.length]
            value = self.instance_variable_get(instance_variable)
            is_primitive = [Hash, String, Integer, Array, NilClass].one? { |type| value.is_a?(type) }
            hash_result[key] = is_primitive ? value : value.to_hash
            hash_result
          end.with_indifferent_access
        end

        def as_request_body
          JSON.generate({ data: { attributes: self.to_hash } })
        end
      end
    end
  end
end