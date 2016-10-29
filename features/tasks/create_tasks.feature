@domain @api
Feature: Creating tasks

  Rules:
  - Name is required
  - Project is required
  - Created tasks should default to "todo" state

  Scenario: Creating a task with all fields
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task with:
      | NAME              | Sample Task                           |
      | DESCRIPTION       | This is a sample task.                |
      | PROJECT_ID        | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  |
      | STATE             | todo                                  |
    Then the system has the tasks:
      | NAME           | STATE              | PROJECT_ID                            |
      | Sample Task    | todo               | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  |


  Scenario: Trying to create a task without a name
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I try to create a task with:
      | DESCRIPTION             | This is a sample task.               |
      | STATE                   | todo                                 |
      | PROJECT_ID              | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then the system has 0 tasks
    And I get the error "Name can't be blank"

  Scenario: Trying to create a task without a project
    When I try to create a task with:
      | NAME                   | Some sample task.         |
      | DESCRIPTION            | This is a sample task.    |
      | STATE                  | todo                      |
    Then the system has 0 tasks
    And I get the error "Project can't be blank"
