# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :integer
#  project_id  :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :project

  enum state: %i{todo in-progress done}

  validates :project, presence: true
end
