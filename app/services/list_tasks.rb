class ListTasks < ListCollection

  # TODO: Fix spelling error
  attr_defaultable :task_respository, -> { Task.where(project_id: @project_id) }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize page: 1, page_size: 25, project_id: nil
    @project_id = project_id

    super(page: page, page_size: page_size)

  end

  def collection_type
    :tasks
  end

  def collection

    if @project_id.nil?
      fail ArgumentError, 'Getting a list of tasks requires a project_id'  
    end

    @tasks ||= task_respository
  end

end
