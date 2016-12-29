module V1
  class TasksController < ApplicationController
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
