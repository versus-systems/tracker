module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'

    swagger_api :create do 
      summary 'Creates a new Task'
      param :form, :name, :string, :required, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
    end
    def create
      project = Project.find(params[:project_id])
      task = project.tasks.new(task_params)
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    swagger_api :index do 
      summary 'List all tasks'
      notes 'This lists all of the active tasks'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 25'
    end
    def index
      tasks = Task.all 
      render json: tasks
    end

    swagger_api :show do
      summary 'Fetch a single Task'
      param :path, :id, :string, :required, 'Task Id'
    end
    def show
      task = Task.find(params[:id]) 
      render json: task
    end

    private

    def task_params
      params.require(:task).permit(
        :name,
        :description,
        :state,
        :project_id
      )
    end

  end
end