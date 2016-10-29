require 'rails_helper'

RSpec.describe V1::TasksController do
  describe 'DELETE /v1/tasks/:id' do
    let(:deleted_task) { FactoryGirl.create(:task) }

    it 'soft-deletes tasks by changing their state to done' do
      expect {
        delete :destroy, id: deleted_task.id
        deleted_task.reload
      }
        .to change(deleted_task, :state).to 'done'
    end
  end
end
