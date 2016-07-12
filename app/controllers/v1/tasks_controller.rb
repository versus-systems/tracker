module V1
  class TasksController < ApplicationController

    def index
      @tasks, errors = ListTasks.new(index_params).call
      render json: @tasks
    end

    def show
      @task = Task.find(params[:id])
      if @task.present?
        render json: @task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        render json: @task, status: 201
      else
        render json: { errors: @task.errors.full_messages }, status: 400
      end
    end

    private

    def index_params
      params.permit(:project_id, :page, :page_size).to_h.symbolize_keys
    end

    def task_params
      params.permit :name, :description
    end
  end
end