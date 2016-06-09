module V1
  class TasksController < ApplicationController

    swagger_api :index do
      summary 'List all tasks for a Project'
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
      param :path, :id, :integer, :required, 'Task Id'
    end
    def show
      task = Task.find_by id: params[:id]
      if task.present?
        render json: task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task for an existing Project'
      param :path, :project_id, :string, :required, 'The Project associated with the Task'
      param :form, :name, :string, :required, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
      param :form, :state, :string, :optional, 'Task state'
    end
    def create
      task = Task.new task_params
      project = Project.find_by id: params[:project_id]

      if project.nil?
        render json: { errors: 'The project was not found. A project is required for each task' }, status: 400
        return
      end

      task.project = project

      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    private

    def index_params
      params.permit(:page, :page_size, :project_id).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit :name, :description, :state
    end
  end
end
