require 'twilio-ruby'
require 'date'
require 'yaml'

require 'pry'

require_relative './retrieve_user_id'
require_relative './user_tweet_timeline'
require_relative './text_msg'

# FYI - Remove parameter to enter twitter username manually
puts '💡 Getting user Twitter ID...'
user_twitter_data = retrieve_user_id('KimKardashian')

twitter_users_name = user_twitter_data[:data][:name]
user_twitter_id = user_twitter_data[:data][:id]

puts "💡 Getting tweets from #{twitter_users_name}..."
user_tweet_timeline = user_tweet_timeline(user_twitter_id)

# Approx current US date
todays_date = (Date.today - 1).to_s

# Filter tweets by current date (based on US)
# Remove link to tweet so it's just text
arr_of_tweets = user_tweet_timeline[:data].filter_map do |tweet|
  tweet_date = tweet[:created_at].split('T')[0]
  tweet[:text].split(' http')[0] if tweet_date == todays_date
end

# Combine arr of tweets into one string
tweets_string = if arr_of_tweets.empty?
                  "No tweets to show ☹️\nHave a great day! 😀"
                else
                  arr_of_tweets.join("\n\n")
                end

puts '🐤 Tweets:'
puts tweets_string
puts ''

# Load phonebook
phonebook = YAML.load_file('./phonebook.yml')

# ⚠️ UN-COMMENTING THE BELOW WILL SEND A TEXT MSG
# ⚠️ TO ENTIRE PHONEBOOK
puts '☎️ Messaging phonebook...'
phonebook.each_key do |key|
  text_msg(twitter_users_name, tweets_string, phonebook[key])
end
