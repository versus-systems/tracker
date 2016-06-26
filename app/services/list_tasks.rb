class ListTasks < ListCollection

  attr_defaultable :task_respository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def collection_type
    :tasks
  end

  def collection
    if @project_id.nil?
      @errors << 'Must provide project ID to query tasks for'
    else
      @tasks ||= task_respository.where(project_id: @project_id)
    end
  end

end
