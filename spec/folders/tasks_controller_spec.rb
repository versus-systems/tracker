require "rails_helper"

RSpec.describe V1::TasksController, type: :controller do 

  describe "POST create" do 
    let!(:project) {Project.create(name: "Project", description: "Cool")}
    it "creates a task for a project" do 
      parameters = {
        project_id: project.id,
        task: {
          name: "Project",
          description: "Description"
        }
      }
      expect{post :create, parameters}.to change(Task, :count).by(1)
      expect(response).to be_success
    end

  end

  describe "GET index" do 

    it "gets all of the projects with their tasks" do 
      task = Task.create!(name: "Name", description: "Desc")
      get :index 
      expect(response).to be_success
      expect{post :create, parameters}.to change(Task, :count).by(1)
    end

  end
end