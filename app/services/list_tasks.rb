class ListTasks < ListCollection

  attr_defaultable :task_repository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize params
  	@project_id = params[:project_id]
  	params.delete :project_id
  	super params
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_repository.not_disabled.where project_id: @project_id
  end

end
