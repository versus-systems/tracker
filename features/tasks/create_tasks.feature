@domain @api
Feature: Creating tasks

  Rules:
  - Name is required
  - Project ID is required
  - Created tasks should default to "todo" state

  Scenario: Creating a task with all fields
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task with:
      | PROJECT ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Task                          |
      | DESCRIPTION | This is a sample task.               |
    Then the system has the tasks:
      | NAME           | STATE  |
      | Sample Task    | todo   |


  Scenario: Trying to create a task without a name
    When I try to create a task with:
      | PROJECT ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | DESCRIPTION | This is a sample task.               |
    Then the system has 0 projects
    And I get the error "Name can't be blank"
