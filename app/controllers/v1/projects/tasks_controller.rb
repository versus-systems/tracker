class V1::Projects::TasksController < ApplicationController
  def index
    @project = Project.find_by(id: params[:id])
    if @project.nil?
      head(404)
    else
      render json: @project.tasks
    end
  end

  def create
    @project = Project.find_by(id: params[:id])
    @task = Task.new(task_params)

    if @project.nil?
      head(404)
    elsif !@task.save
      head(422)
    else
      @project.tasks << @task
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :progress)
  end
end
