module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'
    before_action :set_task, only: [:show, :update, :destroy]

    swagger_api :index do
      summary 'List all tasks'
      notes 'This lists all the tasks for a task'
      param :query, :project_id, :string, :optional, 'Governing Project'
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
      summary 'Fetch a single task'
      param :path, :id, :string, :required, 'Task Id'
    end
    def show
      if @task.present?
        render json: @task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task'
      param :form, :name, :string, :required, 'Task designation'
      param :form, :project_id, :string, :required, 'Governing Project'
      param :form, :description, :string, :optional, 'Task description'
    end
    def create
      task = Task.new task_params
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    swagger_api :update do
      summary 'Updates an existing Task'
      param :path, :id, :string, :required, 'Task Id'
      param :form, :project_id, :string, :optional, 'Governing Project'
      param :form, :name, :string, :optional, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
    end
    def update
      if @task.present? && @task.update_attributes(task_params)
        render json: @task
      elsif @task.present?
        render json: { errors: @task.errors.full_messages }, status: 400
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :destroy do
      summary 'Deletes an existing Task'
      param :path, :id, :string, :required, 'Task Id'
    end
    def destroy
      if @task.present? && @task.update_attributes(state: :done)
        render json: @task
      elsif @task.present?
        render json: { errors: @task.errors.full_messages }, status: 400
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    private

    def index_params
      params.permit(:task_id, :page, :page_size).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit(:project_id, :name, :description, :state)
    end

    def set_task
      @task = Task.find_by_id params[:id]
    end
  end
end
