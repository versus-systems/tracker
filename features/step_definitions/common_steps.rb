When(/^I request the (.*) list$/) do |collection_type|
  d.request_list collection_type, Hash.new
end
When(/^I request the (.*) list of (.*):$/) do |collection_type,resource_type,resource_id|
  resource_id = vertical_table resource_id
  d.request_resource_list collection_type, resource_id[:project_id],resource_type
end
When(/^I request a (.*):$/) do |collection_type,param|
  param = vertical_table param

  d.request_by_id collection_type, param[:id]
end


When(/^I request the (.*) list with parameters:$/) do |collection_type, params|
  params = vertical_table params
  d.request_list collection_type, params
end

Then(/^I get (\d+) (.*) back$/) do |count, kind|
  count = count.to_i
  kind = kind.pluralize.to_sym
  expect(d.results[kind].count).to eq count
end

Then(/^the current page is (\d+)$/) do |page|
  expect(d.results[:current_page_number]).to eq page.to_i
end

Then(/^the total pages is (\d+)$/) do |count|
  expect(d.results[:total_page_count]).to eq count.to_i
end

Then(/^the total results is (\d+)$/) do |count|
  expect(d.results[:count]).to eq count.to_i
end

Then(/^I get the error "([^"]*)"$/) do |message|
  d.verify_error message
end

Then(/^I get the data:$/) do |string|
  data = eval string
  expect(HashDiff.diff d.results.except!(:updated_at, :created_at), data).to be_empty
end
