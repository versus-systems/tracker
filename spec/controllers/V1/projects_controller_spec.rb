require 'rails_helper'

describe V1::ProjectsController, :type => :controller do
  let!(:project) { create(:project) }

  describe "GET list_tasks" do
    let!(:tasks)   { create_list(:task, 3, project_id: project.id) }
    before do
      get 'list_tasks', id: project.id
    end

    it "responds with 200" do
      expect(response.status).to eql(200)
    end

    it "responds with the project's tasks" do
      body = JSON.parse(response.body)
      expect(body.first["id"]).to eql(tasks.first.id)
    end
  end

  describe "POST create_task" do
    let(:task_params) do { name: "My New Task", project_id: project.id } end

    before do
      post 'create_task', task_params
    end

    it "responds with 200" do
      expect(response.status).to eql(200)
    end

    it "responds with the created task" do
      body = JSON.parse(response.body)
      expect(body["name"]).to eql("My New Task")
    end
  end

end
