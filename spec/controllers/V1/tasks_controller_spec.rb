require 'rails_helper'

describe V1::TasksController, :type => :controller do

  let!(:project) { create(:project) }

  describe "PUT update_task_state" do
    let!(:task) { create(:task, project_id: project.id) }
    let!(:update_params) do { project_id: project.id, task_id: task.id, state: "in-progress" } end

    it "responds with 200" do
      put 'update_task_state', update_params
      expect(response.status).to eql(200)
    end

    it "successfully updates the task" do
      expect(task.state).to eql("todo")

      put 'update_task_state', update_params
      body = JSON.parse(response.body)

      task.reload
      expect(body["state"]).to eql("in-progress")
      expect(task.state).to eql("in-progress")
    end

    context "when a task is updated to done" do
      let!(:update_params) do { project_id: project.id, task_id: task.id, state: "done" } end

      it "sends an sms message when updated to done" do
        put 'update_task_state', update_params
        body = JSON.parse(response.body)
        expect(body).to include("completed")
      end

      it "does not send an sms message if the state isn't 'done'" do
        put 'update_task_state', update_params.merge(state: "in-progress")
        body = JSON.parse(response.body)
        expect(body).not_to include("completed")
      end

    end
  end

end
