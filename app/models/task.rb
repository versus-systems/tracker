# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  project_id  :string
#  name        :string
#  description :text
#  state       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, presence: true
  validates :state, presence: true
  validates :project_id, presence: true
  after_commit :send_message, on: :update

  enum state: {
    removed: -1,
    todo: 10,
    in_progress: 20,
    done: 30
  }


  def send_message
    return unless state == 'done'
    TextMessenger.send_text(self)
  end
end
