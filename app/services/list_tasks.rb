class ListTasks < ListCollection

  attr_defaultable :task_repository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_repository.where.not(state: -1)
  end

end
