require 'rails_helper'

RSpec.describe V1::Projects::TasksController, type: :controller do
  describe 'GET projects/:id/tasks' do
    it 'returns a 200' do
      project = double('project')
      allow(project).to receive(:tasks).and_return([])
      Project.stub(:find_by).and_return(project)

      get :index

      expect(response).to have_http_status(200)
    end

    it 'returns a 404 if project does not exist' do
      Project.stub(:find_by).and_return(nil)
      get :index
      expect(response).to have_http_status(404)
    end

    it 'returns all tasks for a given project' do
      tasks = [
        {"name" => "fun task"},
        {"name" => "cool task"},
        {"name" => "boring task"}
      ]
      project = double('project')
      allow(project).to receive(:tasks).and_return(tasks)
      Project.stub(:find_by).and_return(project)

      get :index

      body = JSON.parse(response.body)
      expect(body).to eq(tasks)
    end

    it 'finds a task by its id' do
      expect(Project).to receive(:find_by).with(id: "1")
      get :index, id: 1
    end
  end
end
