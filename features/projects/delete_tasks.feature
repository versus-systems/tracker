@domain @api
Feature: Deleting tasks

  Rules:
  - Id is required
  - Project_Id is required
  - Deleted task should have to "disabled" state

  Scenario: Delete a task
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given a task:
      | ID          | 64f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Task                          |
      | DESCRIPTION | This is a sample task.               |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    When I delete a task with:
      | ID          | 64f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then the system has 0 not disabled tasks