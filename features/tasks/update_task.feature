@domain @api

Feature: The API should update a task

Scenario: Update the state of a project task
Given a project 
And a task
When I send a PUT request to "/tasks/$.task.id" with the following:
"""
{
    "task" : 
      {"state": "in_progress"}
}
"""
Then the response status should be "200"

