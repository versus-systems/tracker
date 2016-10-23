require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
  describe 'GET task/:id' do
    it 'returns a 200' do
      task = "I am a task"
      Task.stub(:find_by).and_return(task)
      get :show, id: 1
      expect(response).to have_http_status(200)
    end

    it 'return a 404 if no resource' do
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
end
