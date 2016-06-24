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
  belongs_to :project
  validates :name, :description, presence: true
  enum state: %w(todo in_progress done)
end
