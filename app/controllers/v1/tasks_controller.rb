class V1::TasksController <  ApplicationController

  def index
    tasks = Task.where(project_id: params[:project_id])
    render json: tasks
  end

  def show
    task = Task.find_by(id: params[:id])
    render json: task
  end

  def create
    task = Task.new project_params
    if task.save
      render json: task, status: 201
    else
      render json: { errors: task.errors.full_messages }, status: 400
    end
  end

  private

  def task_params
      params.require(:task).permit :name, :description, :project_id
  end
end
