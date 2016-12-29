require 'rails_helper'

describe Task do
  let!(:task) { create(:task) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :project_id }
  it { should validate_presence_of :state }

  it "is automatically given a default state upon creation" do
    new_task = Task.new(name: "Default name", project_id: SecureRandom.uuid)
    expect(new_task.state).to eql("todo")
  end

  it "validates that 'todo' is a state" do
    expect(Task.new(name: "Do this thing", project_id: SecureRandom.uuid, state: "todo")).to be_valid
  end

  it "validates that 'in-progress' is a state" do
    expect(Task.new(name: "Do this thing", project_id: SecureRandom.uuid, state: "in-progress")).to be_valid
  end

  it "validates that 'done' is a state" do
    expect(Task.new(name: "Do this thing", project_id: SecureRandom.uuid, state: "done")).to be_valid
  end

  it "does not accept an invalid string as a state" do
    expect(Task.new(name: "Do this thing", project_id: SecureRandom.uuid, state: "blargh")).to be_invalid
  end

  it "should be able to update it's state" do
    task.update_progress!("in-progress")
    task.reload
    expect(task.state).to eql("in-progress")
  end

  it "should send an sms message if the task is 'done'" do
    message = "Hello!"
    task.update_progress!("done")
    task.reload

    expect(task.send_completion_sms?).to eql(true) 
  end
end
