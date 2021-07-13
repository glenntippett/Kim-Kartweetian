require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load('./.env')

require_relative './curl_request'

def retrieve_user_id(username = nil)
  if username.nil?
    puts 'Enter Twitter username'
    username = gets.chomp
  end

  uri = URI.parse("https://api.twitter.com/2/users/by/username/#{username}")
  curl_request(uri)
end
