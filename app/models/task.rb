# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  progress    :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description

  enum progress:[:todo, :in_progress, :done]
end
