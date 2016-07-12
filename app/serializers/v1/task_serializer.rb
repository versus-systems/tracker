module V1
  class TaskSerializer < ActiveModel::Serializer

    attributes :name, :description, :project_id

  end
end