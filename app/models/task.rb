# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  name        :string
#  description :string
#  state       :string
#

class Task < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :state, presence: true

  belongs_to :project

  after_initialize :set_default_state

  private
  def set_default_state
    self.state ||= :active
  end

end
