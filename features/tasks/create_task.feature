@domain @api
Feature: The API should create a task

Scenario: Trying to create a task with all fields
When I create task with:
| NAME        | Sample task |
| DESCRIPTION | Sample task
| PROJECT_ID  | 1           |
Then the system has the task:
| NAME        | PROJECT_ID | DESCRIPTION |
| Sample task | 1          | Sample task

