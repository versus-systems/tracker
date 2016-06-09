require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
  describe '#index' do
    it 'should return default page_size items for existing project' do
      # Given
      dummy_project = create(:project)
      dummy_tasks = create_list(:task, 26, project: dummy_project)

      # When
      get :index, project_id: dummy_project.id
      result_hash = JSON.parse response.body

      # Then
      expect(result_hash['tasks'].length).to eql(25)
    end

    it 'should return error message for non existing project' do
      # Given
      dummy_project_id = 1

      # When
      get :index, project_id: dummy_project_id
      result_hash = JSON.parse response.body

      # Then
      expect(result_hash['count']).to eql(0)
    end

  end

  describe '#show' do
    it 'should return existing task' do
      # Given
      dummy_task = create(:task)

      # When
      get :show, id: dummy_task.id
      result_hash = JSON.parse response.body

      # Then
      expect(result_hash['id']).to eql(dummy_task.id)

    end

    it 'should return error message for non existing task' do
      # Given
      dummy_task_id = 12

      # When
      get :show, id: dummy_task_id
      result_hash = JSON.parse response.body

      # Then
      expect(result_hash['errors']).to eql(['Task not found'])
    end


  end

  describe '#create' do
    it 'should return error for non existing project' do
      # Given
      dummy_project_id = '0000000000000000000000'
      dummy_task = {
        name: 'Test Task2',
        description: 'This is a test of stuff'
      }

      # When
      post :create, { project_id: dummy_project_id, task: dummy_task }
      result_hash = JSON.parse response.body

      # Then
      expect(result_hash['errors']).to eql('The project was not found. A project is required for each task')
    end

    it 'should return success for existing project' do
      # Given
      dummy_project = create(:project)
      dummy_task = {
        name: 'Test Task2',
        description: 'This is a test of stuff'
      }

      # When
      post :create, { project_id: dummy_project.id, task: dummy_task }
      result_hash = JSON.parse response.body

      # Then
      expect(response.status).to eql(201)
    end
  end
end
