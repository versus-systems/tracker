@domain @api
Feature: Creating tasks

  Rules:
  - Name is required
  - Description is required
  - Created projects should default to "to_do" state

  Scenario: Creating a task with all fields
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task with:
      | NAME        | Sample Task                          |
      | DESCRIPTION | This is a sample task.               |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then the system has the tasks:
      | NAME        | STATE                                |
      | Sample Task | to_do                                |

  Scenario: Trying to create a task without a name
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I try to create a task with:
      | DESCRIPTION | This is a sample task.               |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then the system has 0 tasks
    And I get the error "Name can't be blank"

  Scenario: Trying to create a task without a description
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I try to create a task with:
      | NAME        | Sample Task.                         |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then the system has 0 tasks
    And I get the error "Description can't be blank"

  Scenario: Trying to create a task without a description
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I try to create a task with:
      | NAME        | Sample Task.                         |
      | DESCRIPTION | This is a sample task.               |
    Then the system has 0 tasks
    And I get the error "Project can't be blank"
