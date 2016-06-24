# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  project_id  :uuid
#

class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :description, presence: true
end
