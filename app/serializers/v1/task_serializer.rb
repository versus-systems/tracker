module V1
  class TaskSerializer < ActiveModel::Serializer

    attributes :id, :project_id, :name, :description, :state

  end
end
