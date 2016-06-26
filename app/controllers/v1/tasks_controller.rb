module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'

    swagger_api :index do
      summary 'List all tasks for a project'
      notes 'This lists all tasks on a project'
      param :query, :project_id, :uuid, :required, 'project reference'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 25'
    end
    def index
      tasks, errors = ListTasks.new(index_params).call
      if errors.any?
        render json: { errors: errors }, status: 400
      else
        render json: tasks
      end
    end

    swagger_api :show do
      summary 'Fetch a single Task'
      param :path, :id, :string, :required, 'Task Id'
    end
    def show
      task = Task.find params[:id]
      if task.present?
        render json: task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task'
      param :form, :name, :string, :required, 'Task designation'
      param :form, :project_id, :string, :required, 'Project designation'
      param :form, :description, :string, :optional, 'Task description'
    end
    def create
      project = Task.new task_params
      if project.save
        render json: project, status: 201
      else
        render json: { errors: project.errors.full_messages }, status: 400
      end
    end

    private

    def index_params
      params.permit(:page, :page_size, :project_id).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit(:name, :description, :state, :project_id)
    end
  end
end
