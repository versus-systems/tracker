class ListTasks < ListCollection

  attr_defaultable :task_respository,  -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  attr_accessor :project

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= project.tasks.all
  end

end
