module Paymongo
  module Api
    module V1
      module Hashable
        def to_hash
          self.instance_variables.inject({}) do |hash_result, instance_variable|
            key = instance_variable[1..instance_variable.length]
            value = self.instance_variable_get(instance_variable)
            is_primitive = value.is_a?(Hash) || value.is_a?(String) || value.is_a?(Integer) || value.is_a?(Array)
            hash_result[key] = is_primitive ? value : value.to_hash
            hash_result
          end.with_indifferent_access
        end

        def as_json_string
          JSON.generate({ data: { attributes: self.to_hash } })
        end
      end
    end
  end
end