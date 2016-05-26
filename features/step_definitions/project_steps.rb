Given(/^(\d+) projects?$/) do |count|
  d.given_projects count: count
end

Given(/^a project:$/) do |table|
  d.given_project table
end
