require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load('./.env')

def curl_request(uri)
  request = Net::HTTP::Get.new(uri)
  request['Authorization'] = "Bearer #{ENV['BEARER_TOKEN']}"

  req_options = {
    use_ssl: uri.scheme == 'https'
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  JSON.parse(response.body, { symbolize_names: true })
end
