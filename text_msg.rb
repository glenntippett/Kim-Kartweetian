require 'dotenv'
Dotenv.load('./.env')

def text_msg(twitter_users_name, tweets_string, person)
  account_sid = ENV['ACCOUNT_SID']
  auth_token = ENV['AUTH_TOKEN']
  person_to_text = person['name']
  person_phone_number = person['number']

  msg = "Hey #{person_to_text}, it's Kim Kartweetian!\nPlease enjoy #{twitter_users_name}'s tweets of the day 😀\n\n-------\n\n#{tweets_string}"

  begin
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.messages.create(
      body: msg,
      to: person_phone_number,
      from: ENV['MY_NUM']
    )
    puts "✅ Message to #{person_to_text} sent"
  rescue Twilio::REST::TwilioError => e
    puts "❌ Message to #{person_to_text} failed"
    puts e.message
  end
end
