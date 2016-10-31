class ListTasks < ListCollection

  attr_defaultable :task_respository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }


  attr_reader :project_id


  def initialize project_id: nil, page: 1, page_size: 25
    super()
    @project_id = project_id
    raise ArgumentError, 'Project not found' if @project_id.empty?
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_respository.where(:project_id => @project_id)
  end

end
