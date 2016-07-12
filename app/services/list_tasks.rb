class ListTasks < ListCollection

  attr_defaultable :task_respository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize page: 1, page_size: 25, project_id: nil
    @page = page
    @page_size = page_size
    @project_id = project_id
    @errors = []
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_respository.where(project_id: @project_id)
  end

end