module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'tasks'

    swagger_api :index do
      summary 'List all tasks'
      notes 'This lists all the active tasks'
      param :path, :project_id, :string, :required, 'Project Id'
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
      param :path, :project_id, :string, :required, 'Project Id'
      param :path, :id, :string, :required, 'Task Id'
    end
    def show
      task = project.tasks.find_by id: params[:id]

      if task.present?
        render json: serializer.new(task)
      else
        render json: { errors: ['task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new task'
      param :path, :project_id, :string, :required, 'Project Id'
      param :form, :name, :string, :required, 'task name'
      param :form, :description, :string, :optional, 'task description'
    end
    def create
      task = project.tasks.new task_params

      if task.save
        render json: serializer.new(task), status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    swagger_api :update do
      summary 'Updates an existing task'
      param :path, :project_id, :string, :required, 'Project Id'
      param :path, :id, :string, :required, 'Task Id'
      param :form, :name, :string, :optional, 'Task name'
      param :form, :description, :string, :optional, 'Task description'
      param :form, :state, :string, :optional, 'Task state: todo, in-progress or done'
    end
    def update
      task = project.tasks.find_by id: params[:id]

      if task.present? && task.update_attributes(task_params)
        render json: serializer.new(task)
      elsif task.present?
        render json: { errors: task.errors.full_messages }, status: 400
      else
        render json: { errors: ['task not found'] }, status: 404
      end
    end

    swagger_api :destroy do
      summary 'Deletes an existing task'
      param :path, :project_id, :string, :required, 'Project Id'
      param :path, :id, :string, :required, 'task Id'
    end
    def destroy
      task = project.tasks.find_by id: params[:id]

      if task.present? && task.update_attributes(state: :done)
        render json: serializer.new(task)
      elsif task.present?
        render json: { errors: task.errors.full_messages }, status: 400
      else
        render json: { errors: ['task not found'] }, status: 404
      end
    end

    private

    def index_params
      page_params.merge(
        project: project
      )
    end

    def page_params
      params.permit(:page, :page_size).to_h.symbolize_keys
    end

    def project
      @project ||= Project.find(params[:project_id])
    end

    def task_params
      params.require(:task).permit :name, :description
    end

    def serializer
      V1::TaskSerializer
    end
  end
end
