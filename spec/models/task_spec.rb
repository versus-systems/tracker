require "rails_helper"

RSpec.describe Task, type: :model do 
  it { should belong_to(:project) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  it "should have the attributes of name and description and state" do
    task = Task.create(name: "Name", description: "Description")
    expect(task.name).to eq("Name")
    expect(task.description).to eq("Description")
    expect(task[:state]).to eq("todo")
  end

  it "can have two other different states" do 
    task = Task.create(name: "Name 2", description: "Description 2")
  end

end