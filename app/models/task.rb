# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :string
#  project_id  :uuid
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#

class Task < ActiveRecord::Base
  belongs_to :project

  STATES = ["todo", "in-progress", "done" ]
  # "todo" => task has not been started
  # "in-progress" => task is in progress
  # "done" => task has been completed

  validates :name, presence: true
  validates :state, presence: true, inclusion: { in: STATES }
  validates :project_id, presence: true

  after_initialize :set_default_state

  def update_progress!(state)
    self.state = state
    self.save!
  end

  def send_completion_sms?
    if self.state == "done"
      message = "Hooray! Task Complete!"
      send_message_via_sms(message)
      true
    else
      false
    end
  end

  def send_message_via_sms(message)
    client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )

    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: ENV['MY_NUMBER'],
      body: message
    )
  end

  def set_default_state
    self.state ||= "todo"
  end
end
