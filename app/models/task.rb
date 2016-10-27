# == Schema Information
#
# Table name: tasks
#
#  id               :uuid             not null, primary key
#  name             :string
#  description      :string
#  state            :integer
#  project_id       :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true
  validates :project_id, presence: true

  after_initialize :set_default_state

  enum state: {
    todo: 10,
    in_progress: 20,
    completed: 30
  }

  def project_name
    project.name
  end

  private

  def set_default_state
    self.state ||= :todo
  end
end
