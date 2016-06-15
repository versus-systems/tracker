# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string           not null
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
end
