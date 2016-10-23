module V1
  class TasksController < ApplicationController
    def show
      @task = Task.find_by(id: params[:id])
      if @task.nil?
        head(404)
      else
        render json: @task
      end
    end
  end
end
