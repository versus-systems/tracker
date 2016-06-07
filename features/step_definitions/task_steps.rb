Given(/^(\d+) tasks?$/) do |count|
  d.given_tasks count: count
end

Given(/^a task:$/) do |table|
  d.given_task table
end

When(/^I (?:try to )?create a task with:$/) do |table|
  attributes = vertical_table table
  d.create_task attributes
end

When(/^I (?:try to )?delete a task with:$/) do |table|
  attributes = vertical_table table
  a.delete_task attributes
end

Then(/^the system has the tasks:$/) do |table|
  ActiveCucumber.diff_all! Task.order(:created_at), table
end

Then(/^the system has (\d+) tasks?$/) do |count|
  expect(Task.count).to eq count.to_i
end

Then(/^the system has (\d+) not disabled tasks?$/) do |count|
  expect(Task.not_disabled.count).to eq count.to_i
end
