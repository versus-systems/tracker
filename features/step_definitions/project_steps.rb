Given(/^(\d+) projects?$/) do |count|
  d.given_objects name: 'project', count: count
end

Given(/^a project:$/) do |table|
  d.given_project table
end

When(/^I request the (.*) list$/) do |collection_type|
  d.request_list collection_type, Hash.new
end

When(/^I request the (.*) list with parameters:$/) do |collection_type, params|
  params = vertical_table params
  d.request_list collection_type, params
end

When(/^I (?:try to )?create a project with:$/) do |table|
  attributes = vertical_table table
  d.create_project attributes
end

Then(/^the system has the projects:$/) do |table|
  ActiveCucumber.diff_all! Project.order(:created_at), table
end

Then(/^the system has (\d+) projects?$/) do |count|
  expect(Project.count).to eq count.to_i
end
