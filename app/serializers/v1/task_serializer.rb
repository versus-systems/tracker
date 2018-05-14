class V1::TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :project_id, :state
  
end
