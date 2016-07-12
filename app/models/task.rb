# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  state       :integer          default(-1)
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_name  (name) UNIQUE
#

class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true
  validates :description, presence: true

  after_initialize :set_default_state

  enum state: {
    todo: -1,
    in_progess: 10,
    done: 20
  }

  private

  def set_default_state
    self.state ||= :todo
  end
end
