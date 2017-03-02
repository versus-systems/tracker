require 'rails_helper'

RSpec.describe ListTasks do
  describe "#collection" do
    before do
      Task.create(name: 'My task', project_id: '1', state: :removed)
    end

    let(:list_tasks) { ListTasks.new }

    it "should not return destroyed (removed) tasks" do
      expect(list_tasks.collection).to be_empty
    end
  end
end
