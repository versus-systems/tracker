class ListTasks < ListCollection

  attr_defaultable :task_repository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_repository.all.reject{|t| t.state == 'removed'}
  end

end
