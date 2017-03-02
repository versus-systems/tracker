class ListTasks < ListCollection

  attr_defaultable :task_repository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize project_id: nil
    super()
    @project_id = project_id
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_repository.where(project_id: project_id).where.not(state: -1)
  end

  attr_reader :project_id
end
