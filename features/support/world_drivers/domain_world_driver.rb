class DomainWorldDriver < WorldDriver

  def initialize
    p 'Running Features in the Domain World'
    super
  end

  def request_list collection_type, params
    @results, e = "List#{collection_type.camelize}".constantize.new(params).call
    @errors.push *e
  end


  def request_resource_list collection_type,resource_id,resource_type
    result = Hash.new
    result["#{resource_type.downcase.singularize}_id".to_sym] = resource_id
    begin
      @results, e = "List#{collection_type.camelize}".constantize.new(result).call
      @errors.push *e
    rescue ArgumentError => e
      @results = nil
      @errors.push *e.message
    end
  end


  def request_by_id collection_type, resource_id
    response = "#{collection_type.camelize}".constantize.find_by_id(resource_id)
    if response
      @results, e = response.to_show
      @errors.push *e
    else
      @results = nil
      @errors.push "#{collection_type.camelize} not found"
    end

  end


  def create_project params
    project = Project.create params
    @errors.push *project.errors.full_messages
  end

  def create_task params
    task = Task.create params
    @errors.push *task.errors.full_messages
  end

end
