require 'rails_helper'

RSpec.describe ListProjects do
  describe "#collection" do
    before do
      Project.create(name: 'proj1', state: :disabled)
    end

    let(:list_projects) { ListProjects.new }

    it "should return only active projects" do
      expect(list_projects.collection).to be_empty
    end
  end
end
