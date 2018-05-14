class V1::TasksController <  ApplicationController
  include Swagger::Docs::Methods

  def index
    tasks = Task.where(project_id: params[:project_id])
    render json: tasks
  end

  def show
    begin
      project = Project.find(params[:project_id])
      task = project.tasks.find(params[:id])
      render json: task, serializer: V1::TaskSerializer
    rescue StandardError => e
       render json: { errors: e.message }, status: 400
    end

  end

  def create
    project_id = params[:project_id]
    task = Task.new task_params
    if task.save
      render json: task, status: 201
    else
      render json: { errors: task.errors.full_messages }, status: 400
    end
  end

  def update   
    task = Task.find(params[:id])
    status = params[:status]

    if task.present? 
      begin
        task.public_send("#{update_state_params[:status]}!")
        render json: task, serializer: V1::TaskSerializer
      rescue StandardError => e
        render json: { errors: e.message }, status: 400 
      end
    else
      render json: { errors: ['Task not found'] }, status: 404
    end
  end


  private
  def index_params
    params.require(:task).permit :project_id
  end

  def task_params
    params.require(:task).permit :name, :project_id
  end

  def update_state_params
    params.require(:task).permit(:status)
  end

end
