module V1
  class TasksController < ApplicationController
    swagger_controller :task, 'Tasks'

    swagger_api :index do
      summary 'List all tasks'
      notes 'This lists all the active tasks for a project'
    end

    def index
      begin
        tasks = Task.where(project_id: params[:id])
        render json: tasks, status: 200
      rescue => e
        render json: { errors: e }, status: 400
      end
    end

    swagger_api :show do #Add show action params, with descriptions
      summary 'Show a task'
      notes 'Shows all info for a given task'
    end
    def show
      begin
        task = Task.where(id: params[:id])
        render json: task, status: 200
      rescue => e
        render json: { errors: e }, status: 400
      end
    end

    def create
      task = Task.new(task_params)
      if task.save
        render json: { message: "Task was created under task id: #{task.id}"}, status: 201
      else
        render json: { errors: task.errors.full_messages.join(", ") }, status: 500
      end
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :project_id, :state)
    end

  end
end
