module V1
  class TasksController < ApplicationController

    def update_task_state
      task = Task.find_by(id: params[:task_id])
      task.update_progress!(params[:state])
      if task.state == "done"
        message = "Hooray! Task Complete!"
        send_message_via_sms(message)
        render status: 201
      else
        render json: task, serializer: TaskSerializer
      end
    end

    private

    def send_message_via_sms(message)
      client = Twilio::REST::Client.new(
        ENV['TWILIO_ACCOUNT_SID'],
        ENV['TWILIO_AUTH_TOKEN']
      )

      client.messages.create(
        from: ENV['TWILIO_NUMBER'],
        to: ENV['MY_NUMBER'],
        body: message
      )
    end

  end
end
