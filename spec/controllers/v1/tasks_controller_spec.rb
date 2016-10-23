require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
  describe 'GET task/:id' do
    it 'returns a 200 if task exists' do
      task = "I am a task"
      Task.stub(:find_by).and_return(task)
      get :show, id: 1
      expect(response).to have_http_status(200)
    end

    it 'return a 404 if task does not exist' do
      Task.stub(:find_by).and_return(nil)
      get :show, id: 1
      expect(response).to have_http_status(404)
    end

    it 'returns information about that task' do
      task = create(:task)
      Task.stub(:find_by).and_return(task)
      get :show, id: 1

      body = JSON.parse(response.body)

      task.attributes do |attribute|
        expect(body[attribute.to_s]).to eq(task.attribute)
      end
    end

    it 'finds a task by its id' do
      expect(Task).to receive(:find_by).with(id: "1")
      get :show, id: 1
    end
  end

  describe 'GET projects/:id/tasks' do
    it 'returns a 200' do
      project = double('project')
      allow(project).to receive(:tasks).and_return([])
      Project.stub(:find_by).and_return(project)
      get :index, project_id: 1

      expect(response).to have_http_status(200)
    end

    it 'returns a 404 if project does not exist' do
      Project.stub(:find_by).and_return(nil)
      get :index, project_id: 1
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

      get :index, project_id: 1

      body = JSON.parse(response.body)
      expect(body).to eq(tasks)
    end

    it 'finds a task by its id' do
      expect(Project).to receive(:find_by).with(id: "1")
      get :index, project_id: 1
    end
  end

  describe 'POST projects/:id/tasks' do
    it 'returns a 200' do
      project = double('project')
      Project.stub(:find_by).and_return(project)
      allow(project).to receive(:tasks)
      allow(project.tasks).to receive(:<<)

      @controller.stub(:task_params)

      task = create(:task)
      Task.stub(:new).and_return(task)
      Task.any_instance.stub(:save).and_return(true)

      post :create, project_id: 1

      expect(response).to have_http_status(200)
    end

    it 'returns a 404 if project does not exist' do
      Project.stub(:find_by).and_return(nil)
      @controller.stub(:task_params)
      Task.stub(:new)
      Task.any_instance.stub(:save).and_return(true)

      post :create, project_id: 1

      expect(response).to have_http_status(404)
    end

    it 'returns a 422 if task data is invalid' do
      Project.stub(:find_by).and_return('a project that exists')
      @controller.stub(:task_params)
      task = create(:task)
      Task.stub(:new).and_return(task)
      Task.any_instance.stub(:save).and_return(false)

      post :create, project_id: 1

      expect(response).to have_http_status(422)
    end

    it 'project is found with an id' do
      @controller.stub(:task_params)
      expect(Project).to receive(:find_by).with(id: "1")
      post :create, project_id: 1
    end

    it 'task is built with params' do
      expect(Task).to receive(:new).with(name: "grocery shopping", description: "whole paycheck")
      post :create, project_id: 1, task: { name: "grocery shopping", description: "whole paycheck" }
    end
  end
end
