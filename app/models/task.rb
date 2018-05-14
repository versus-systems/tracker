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
#  aasm_state  :string
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

    include AASM

    aasm column: :state do
        state :todo, initial: true
        state :in_progress
        state :done

        event :start do
            transitions from: :todo, to: :in_progress
        end

        event :unstart do
            transitions from: :in_progress, to: :todo
        end
       
        event :complete, after:  :notify do
            transitions from: :in_progress, to: :done
        end  
    end
    
    private

    def notify
        "Task #{id} is completed!"             
    end

end
