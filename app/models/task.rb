# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  project_id  :uuid
#  state       :string           default("todo")
#

class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :description, :state, presence: true
end
