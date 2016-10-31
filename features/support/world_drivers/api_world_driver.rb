class ApiWorldDriver < WorldDriver
  include Rack::Test::Methods

  def initialize
    p 'Running Features in the API World'
    super
  end

  def app
    Rails.application
  end

  def request_list collection_type, params
    result = get "/v1/#{collection_type}?#{params.to_query}"
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end


  def request_resource_list collection_type,resource_id,resource_type
    pluralize_resource = resource_type.pluralize
    result = get "/v1/#{pluralize_resource}/#{resource_id}/#{collection_type}"

    if result[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      body = JSON.parse(result.body).deep_symbolize_keys
      if body[:errors].present?
        @errors.push *body[:errors]
        @results = nil
      else
        @results = body
      end
    end
  end

  def request_by_id resource_type, resource_id
    begin
      result = get "/v1/#{resource_type.pluralize}/#{resource_id}"
      body = JSON.parse(result.body).deep_symbolize_keys
      if body[:errors].present?
        @errors.push *body[:errors]
        @results = nil
      else
        @results = body
      end
    rescue ActionController::RoutingError => e
      @results = nil
      @errors.push "#{resource_type.singularize.camelize} not found"
    end
  end


  def create_project attributes
    result = post '/v1/projects', { project: attributes }
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  def create_task attributes
    result = post "/v1/projects/#{attributes[:project_id]}/tasks", { task: attributes }
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

end
