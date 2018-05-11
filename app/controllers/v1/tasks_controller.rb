class V1::TasksController <  ApplicationController

    swagger_api :create do
        summary 'Creates a new Task'
        param :form, :name, :string, :required, 'Task name'
        param :form, :description, :string, :required, 'Task description'
    end

    def def create
      task = Task.new project_params
      if task.save
        render json: task, status: 201
      else
        render json: { errors: project.errors.full_messages }, status: 400
      end
    end

    private

    def task_params
        params.require(:task).permit :name, :description
    end
end
