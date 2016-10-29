require 'rails_helper'

RSpec.describe V1::ProjectsController do
  describe 'DELETE /v1/projects/:id' do
    let(:deleted_project) { FactoryGirl.create(:project) }

    it 'soft-deletes projects by changing their state to disabled' do
      expect {
        delete :destroy, id: deleted_project.id
        deleted_project.reload
      }
        .to change(deleted_project, :state).to 'disabled'
    end
  end
end
