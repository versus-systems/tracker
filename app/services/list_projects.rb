class ListProjects < ListCollection

  # TODO: Fix spelling error
  attr_defaultable :project_respository, -> { Project }
  attr_defaultable :result_serializer, -> { V1::ProjectSerializer }

  def collection_type
    :projects
  end

  def collection
    @projects ||= project_respository.active
  end

end
