# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :string
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
  belongs_to :project

  enum state: [:todo, :in_progress, :done]

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true
  validates :project_id, presence: true
end
