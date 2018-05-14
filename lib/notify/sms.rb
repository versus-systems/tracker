
require 'twilio-ruby'

class NotifySMS
  def initialize(from, to)
    @from = from
    @to = to
  end

  def notify(message)
    # Your Account Sid and Auth Token from twilio.com/console
    if Rails.env == 'production'
      account_sid = ENV["TWILIO_ACCOUNT_SID"]
      auth_token = ENV["TWILIO_AUTH_TOKEN"]
      @client = Twilio::REST::Client.new(account_sid, auth_token)

      message = @client.messages
        .create(
          body: message, #'This is the ship that made the Kessel Run in fourteen parsecs?',
          from: @from, #'+14243721708'
          to: @to
        )
    end
  end

  def message_status
    if Rails.env != 'production'
      'success'

      @client = Twilio::REST::Client.new @twilio_account_id, @twilio_auth_token
      message = @client.messages.get(message.sid)
      message.status
  end
end