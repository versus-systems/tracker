# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :uuid
#
# Foreign Keys
#
#  fk_rails_02e851e3b7  (project_id => projects.id)
#

class Task < ActiveRecord::Base
    validates :name, presence: true
    validates :description, presence: true
    validates :state, presence: true
    validates :project_id, presence: true

    attr_accessor :project

    belongs_to :project

    after_initialize :set_default_state

    private
    def set_default_state
        self.state ||= :todo
    end
end
