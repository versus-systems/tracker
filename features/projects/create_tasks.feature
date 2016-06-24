@domain @api
Feature: Creating tasks

Rules:
- Name is required
- Description is required
- Created tasks should default to "todo" state

Scenario: Creating a task with all fields
  When I create a task with:
  | NAME        | Task Name      |
  | DESCRIPTION | Description    |
  | STATE       | todo           |
  Then the system has the tasks:
  | NAME         | STATE |
  | Task Name    | todo  |

Scenario: Trying to create a task without a name or description
  When I try to create a project with:
  | STATE | todo |
  Then the system has 0 tasks
  And I get the error "Name and description can't be blank"