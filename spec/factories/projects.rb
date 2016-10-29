# == Schema Information
#
# Table name: projects
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#

FactoryGirl.define do
  factory :project do
    name
    description 'A sample project'
  end
end
