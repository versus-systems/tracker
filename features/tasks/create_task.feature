@domain @api
Feature: The API should create a task

Scenario: Trying to create a task with all fields
When I create task with:
| NAME        | Sample task           |
| DESCRIPTION | This is a sample task |
| STATE       | todo                  |
Then the system has the task:
| NAME        | DESCRIPTION           | STATE |
| Sample task | This is a sample task | todo  |

