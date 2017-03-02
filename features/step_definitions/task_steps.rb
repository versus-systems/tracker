Given(/^(\d+) tasks?$/) do |count|
  d.given_objects name: 'task', count: count
end

Given(/^a task:$/) do |table|
  d.given_task table
end

When(/^I request this project's (.*) list with parameters:$/) do |collection_type, params|
  params = vertical_table params
  d.request_list collection_type, params
end

When(/^I (?:try to )?create a task with:$/) do |table|
  attributes = vertical_table table
  d.create_task attributes
end

When(/^I destroy a task with:$/) do |table|
  attributes = vertical_table table
  d.create_task attributes
end

Then(/^the system has the tasks:$/) do |table|
  ActiveCucumber.diff_all! Task.order(:created_at), table
end

Then(/^the system has (\d+) tasks?$/) do |count|
  expect(Task.count).to eq count.to_i
end
