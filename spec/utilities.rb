module Utilities
  def cassette_response(path_to_cassete, request_number = 1)
    requests = YAML.load_file(File.expand_path("cassettes/#{path_to_cassete}", __dir__))['http_interactions']

    raise ArgumentError.new('Request not found! Please check the YML file and determine the correct sequence of request starting from "1" based on the number of http interactions (- request) on that test') if request_number < 1 || request_number > requests.size

    JSON.parse(requests[request_number - 1]['response']['body']['string'])
  end
end