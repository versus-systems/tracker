class TextMessenger
  TWILIO_CLIENT = Twilio::REST::Client.new

  def self.send_text(task)
    phone = task&.project&.phone
    return unless phone
    TWILIO_CLIENT.messages.create(
      from: '+13238941622', # my default valid from number for test acct
      to: phone,
      body: "Task complete!\n#{task.name}"
    )
  end
end
