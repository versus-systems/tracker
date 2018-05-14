require 'rubygems'
require 'twilio-ruby'

class NotifySMS
    def initialize(message)
      @message = message
    end

    def notify
      # TODO create twilio client and send sms here
      @message
    end

    def message_status
      # TODO get message status from twilio api
      "success"
    end
end