require 'rails_helper'

RSpec.describe V1::TasksController, :type => :request do
  let(:project) { FactoryGirl.create(:project) }

  before :each do
    3.times { project.tasks << FactoryGirl.create(:task) }
  end

  describe 'GET index' do
    it 'returns all tasks for a given project' do
      get v1_tasks_path, { project_id: project.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['tasks'].count).to eq(3)
    end
  end

  describe 'POST create' do
    it 'creates a task on a given project' do
      args = { name: 'Create task',
               project_id: project.id,
               description: 'Test create task' }
      post v1_tasks_path, { task: args }
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET show' do
    it 'returns a single task by its ID' do
      first_task = project.tasks.first
      first_task_json = first_task.as_json(except: [:created_at, :updated_at])
      get v1_task_path(first_task)
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      json_response.delete('created_at')
      json_response.delete('updated_at')
      expect(json_response).to eq(first_task_json)
    end
  end

end

