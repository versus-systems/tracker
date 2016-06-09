# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  state       :integer          default(0)
#  project_id  :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#

class Task < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :state, presence: true
  validates :project, presence: true

  belongs_to :project, inverse_of: :tasks

  after_initialize :set_default_state

  enum state: {
    todo: 0,
    in_progress: 10,
    done: 20
  }

  private

  def set_default_state
    self.state ||= :todo
  end
end
