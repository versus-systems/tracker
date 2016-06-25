# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  project_id  :uuid
#  state       :integer          default(0)
#

class Task < ActiveRecord::Base
  belongs_to :project, inverse_of: :tasks
  validates :name, :description, presence: true
  enum state: {
    todo: 0,
    in_progress: 1,
    done: 2
  }
end
