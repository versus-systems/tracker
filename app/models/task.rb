# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  project_id  :uuid
#  name        :string
#  description :text
#  state       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_02e851e3b7  (project_id => projects.id)
#

class Task < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :description, presence: true
  validates :project_id, presence: true

  scope :not_disabled, -> { where.not(state: -1) }

  after_initialize :set_default_state

  belongs_to :project

  enum state: {
    disabled: -1,
    to_do: 10,
    in_progress: 20,
    done: 30
  }

  private

  def set_default_state
    self.state ||= :to_do
  end
end
