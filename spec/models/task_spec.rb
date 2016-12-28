require 'rails_helper'

describe Task do
  let!(:task) { create(:task) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :project_id }
  it { should validate_presence_of :state }
end
