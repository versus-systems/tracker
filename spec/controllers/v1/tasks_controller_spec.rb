require 'rails_helper'

RSpec.describe V1::TasksController do
  describe "#index" do
    it "return all project's tasks" do
      task = FactoryGirl.create :task

      get :index, project_id: task.project.id

      expect(response.status).to eq 200
      expect(response_body[:tasks]).to eq [
        V1::TaskSerializer.new(task).attributes
      ]
    end

    context "given some errors" do
      it "return errors" do
        allow_any_instance_of(ListCollection).to receive(:errors).and_return(["error"])

        project = FactoryGirl.create :project

        get :index, project_id: project.id

        expect(response.status).to eq 400
        expect(response_body).to   eq({ errors: ["error"] })
      end
    end
  end

  describe "#show" do
    it "return spefific project's tasks" do
      task = FactoryGirl.create :task

      get :show, project_id: task.project.id, id: task.id

      expect(response.status).to eq 200
      expect(response_body).to   eq V1::TaskSerializer.new(task).attributes
    end

    context "given an inexistent task id" do
      it "returns 404" do
        project = FactoryGirl.create :project

        get :show, project_id: project.id, id: "SOME-PROJE-CTID"

        expect(response.status).to eq 404
        expect(response_body).to   eq({ errors: ["task not found"] })
      end
    end
  end

  describe "#create" do
    it "credates task" do
      task = FactoryGirl.create :task

      post :create, project_id: task.project.id, task: {name: "new test name"}

      expect(response.status).to      eq 201
      expect(response_body[:name]).to eq "new test name"
    end

    context "given some errors" do
      it "returns status 400" do
        task = FactoryGirl.create :task
        allow_any_instance_of(Task).to receive(:save).and_return(false)

        post :create, project_id: task.project.id, task: {name: ""}

        expect(response.status).to eq 400
      end
    end
  end

  describe "#update" do
    it "return spefific project's tasks" do
      task = FactoryGirl.create :task

      put :update, project_id: task.project.id, id: task.id, task: {name: "new test name"}

      expect(response.status).to eq 200
      expect(response_body[:name]).to eq "new test name"
    end

    context "given errors on update" do
      it "returns status 400" do
        task = FactoryGirl.create :task
        allow_any_instance_of(Task).to receive(:update_attributes).and_return(false)

        put :update, project_id: task.project.id, id: task.id, task: {name: "new test name"}

        expect(response.status).to eq 400
      end
    end

    context "given a fake task id" do
      it "returns status 404" do
        project = FactoryGirl.create :project

        put :update, project_id: project.id, id: "FAKE-ID", task: {name: "new test name"}

        expect(response.status).to eq 404
        expect(response_body).to   eq({ errors: ["task not found"] })
      end
    end
  end

  describe "#destroy" do
    it "destroys a task" do
      task = FactoryGirl.create :task

      delete :destroy, project_id: task.project.id, id: task.id

      expect(response.status).to eq 200
      expect(response_body[:state]).to eq "done"
    end

    context "given a fake task id" do
      it "returns status 404" do
        project = FactoryGirl.create :project

        delete :destroy, project_id: project.id, id: "FAKE-ID"

        expect(response.status).to eq 404
        expect(response_body).to eq({ errors: ["task not found"] })
      end
    end
  end

  def response_body
    JSON.parse(response.body, symbolize_names: true)
  end
end
