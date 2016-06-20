require 'rails_helper'

describe V1::TasksController, :type => :controller do
  describe '#index' do
    it 'returns all the tasks given a project id' do
      # test setup
      project = FactoryGirl.create(:project)
      5.times { project.tasks << FactoryGirl.create(:task) }

      project2 = FactoryGirl.create(:project)
      2.times { project2.tasks << FactoryGirl.create(:task) }

      get :index, id: project.id
      json = JSON::parse(response.body)
      expect(json.count).to eq(7)
    end

  end

  describe '#show' do
    it 'returns the task given the task id' do
      5.times { FactoryGirl.create(:task) }
      task = FactoryGirl.create(:task)

      get :show, id: task.id
      json = JSON::parse(response.body)
      expect(json[0]["id"]).to eq(task.id)
    end
  end

  describe '#create' do
    it 'creates a task given task parameters' do
      task = FactoryGirl.attributes_for(:task)
      expect {
        post :create, task: task
      }.to change(Task, :count).by(1)
      expect(response.status).to eq(201)
    end
  end
end
