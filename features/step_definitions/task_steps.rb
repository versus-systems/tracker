
When(/^I create task with:$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  attributes = vertical_table table
  @task = Task.create(attributes)
end

Then(/^the system has the task:$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  ActiveCucumber.diff_all! Task.order(:created_at), table
end

When(/^I specify a project$/) do
  @project = Project.create(name: "Sample Project") 

  5.times do |i|
    @task = Task.create(name: "Sample Task #{i}", 
      description: "This is a sample task",
      project_id: @project.id)

  end
end

When(/^the project has (\d+) tasks$/) do |arg1|
  @project = Project.first
  
end

Then(/^I get (\d+) tasks$/) do |arg1|
  @project = Project.first
  
end
