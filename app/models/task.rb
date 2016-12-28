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

  validates :name, presence: true
  validates :state, presence: true
  validates :project_id, presence: true

end
