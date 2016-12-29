module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'

    swagger_api :update do
      summary 'Updates an existing Task'
      param :task_id, :integer, :required, 'Task Id'
    end
    def update_task_state
      task = Task.find_by(id: params[:task_id])
      task.update_progress!(params[:state])
      if task.send_completion_sms?
        render json: { completed: task }, root: false
      else
        render json: task, serializer: TaskSerializer, root: false
      end
    end

  end
end
