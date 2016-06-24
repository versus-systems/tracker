require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :state }
  it { should have_many(:tasks) }

  before(:each) do 
    @project = Project.create(name: "Project 1", description: "Super Cool")
  end

  it "should have tasks" do 
    @project.tasks.create({name: "Name 1", description: "Description 1"})
    @project.tasks.create({name: "Name 2", description: "Description 2"})
    expect(@project.tasks.count).to eq(2)
  end
end
