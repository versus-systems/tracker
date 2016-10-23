class V1::Projects::TasksController < ApplicationController
  def index
      @project = Project.find_by(id: params[:id])
      if @project.nil?
        head(404)
      else
        render json: @project.tasks
      end
  end
end
