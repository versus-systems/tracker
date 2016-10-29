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

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :state }
  it { should validate_presence_of :project_id }
end
