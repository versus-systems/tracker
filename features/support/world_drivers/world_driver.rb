class WorldDriver
  include RSpec::Matchers

  attr_reader :errors, :results

  def initialize
    @results = nil
    @errors = []
  end

  def given_objects name: nil, count: nil, data: nil
    if count.present?
      FactoryGirl.create_list name.to_sym, count.to_i
    elsif data.present?
      ActiveCucumber.create_many name.capitalize.constantize, data
    else
      fail 'No projects given'
    end
  end

  def given_project data
    ActiveCucumber.create_one Project, data
  end

  def given_task data
    ActiveCucumber.create_one Task, data
  end

  def check_unexpected_errors
    errors.present? && fail("Unexpected errors happened:\n #{errors.join("\n")}")
  end

  def verify_error error_message
    error_included = errors.any? { |error| error.include? error_message }
    expect(error_included).to eq true
    errors.delete_if { |error| error.include? error_message }
  end

end
