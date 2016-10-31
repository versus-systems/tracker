# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  project_id  :uuid               foreign key
#  name        :string
#  description :text
#  state       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
#
#
#
#

class Task < ActiveRecord::Base
  validates :name, presence: true
  validates :state, presence: true

  after_initialize :set_default_state

  belongs_to :project
  validates :project_id, :presence => true, allow_nil: false,  :on => :index

  enum state: {
           todo: -1,
           in_progress: 10,
           done: 20
       }
  def to_show
    attributes = self.attributes
    attributes["state"] = self.state
    attributes.symbolize_keys
  end
  private

  def set_default_state
    self.state ||= :in_progress
  end




end
