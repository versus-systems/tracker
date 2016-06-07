module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'

    swagger_api :index do
      summary 'List all project tasks'
      notes 'This lists all of a project\'s tasks'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 25'
    end
    def index
      projects, errors = ListTasks.new(index_params).call
      if errors.any?
        render json: { errors: errors }, status: 400
      else
        render json: projects
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
      param :form, :name, :string, :required, 'Task name'
      param :form, :description, :string, :optional, 'Task description'
    end
    def create
      task = Task.new task_params
      task.project_id = params[:project_id]
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    swagger_api :destroy do
      summary 'Deletes an existing Task'
      param :path, :id, :string, :required, 'Task Id'
    end
    def destroy
      task = Task.find params[:id]
      if task.present? && task.update_attributes(state: :disabled)
        render json: task
      elsif task.present?
        render json: { errors: task.errors.full_messages }, status: 400
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    private

    def index_params
      params.permit(:project_id, :page, :page_size).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit :name, :description
    end
  end
end
