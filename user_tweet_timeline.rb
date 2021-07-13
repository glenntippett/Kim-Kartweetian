require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load('./.env')

def user_tweet_timeline(user_id = nil)
  if user_id.nil?
    puts 'Enter user Twitter ID'
    user_id = gets.chomp
  end
  uri = URI.parse("https://api.twitter.com/2/users/#{user_id}/tweets?tweet.fields=created_at")
  curl_request(uri)
end
