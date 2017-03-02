class ApiWorldDriver < WorldDriver
  include Rack::Test::Methods

  def initialize
    p 'Running Features in the API World'
    super
  end

  def app
    Rails.application
  end

  def build_url collection_type, params
    case collection_type
    when 'tasks'
      "/v1/projects/#{params[:project_id]}/tasks"
    when 'projects'
      "/v1/projects?#{params.to_query}"
    end
  end

  def request_list collection_type, params
    result = get build_url(collection_type, params)
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
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
