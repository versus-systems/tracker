require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :state }
  it { should validate_presence_of :project_id }

  it "should have initial state of todo" do
    project = Project.create(name: "Sample Project")
    task = Task.new(name: "Sample Task", project_id: project.id)
    expect(task.state).to eq("todo")
  end
  
  it "should allow transition from todo to in_progress" do
    project = Project.create(name: "Sample Project")
    task = Task.new(name: "Sample Task", project_id: project.id)
    task.start
    expect(task.state).to eq("in_progress")
  end

  it "should allow transition from in_progress to done" do
    project = Project.create(name: "Sample Project")
    task = Task.new(name: "Sample Task", project_id: project.id)
    task.start
    task.complete
    expect(task.state).to eq("done")
  end

  it "should not allow transition from done to todo" do
    project = Project.create(name: "Sample Project")
    task = Task.new(name: "Sample Task", project_id: project.id)
    task.start
    task.complete
    expect { task.start }.to raise_error(AASM::InvalidTransition)
  end

end
