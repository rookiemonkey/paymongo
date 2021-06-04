module Utilities
  def cassette_response(path_to_cassete)
    JSON.parse(YAML.load_file(File.expand_path("cassettes/#{path_to_cassete}", __dir__))['http_interactions'].first['response']['body']['string'])
  end
end