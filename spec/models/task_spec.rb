require "rails_helper"

RSpec.describe Task, type: :model do 
  it { should belong_to(:project) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :state }

  it "should have the attributes of name and description" do
    task = Task.create(name: "Name", description: "Description")
    expect(task.name).to eq("Name")
    expect(task.description).to eq("Description")
  end

end