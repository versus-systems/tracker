# == Schema Information
#
# Table name: tasks
#
#  id               :uuid             not null, primary key
#  name             :string
#  description      :string
#  state            :integer
#  project_id       :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :task do
    name
    description 'A sample task'
    state 10
    project
  end
end
