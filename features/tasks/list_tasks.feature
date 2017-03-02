@domain @api
Feature: Listing tasks

  Scenario: Verifying the format shape
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given a task:
      | PROJECT ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | ID          | 42                                   |
      | NAME        | Sample Task                          |
      | DESCRIPTION | A small sample task                  |
    When I request this project's tasks list with parameters:
      | PROJECT ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then I get the data:
      """
      {
        tasks: [
          {
            id: 42,
            name: 'Sample Task',
            description: 'A small sample task',
            state: 'todo'
          }
        ],
        count: 1,
        current_page_number: 1,
        total_page_count: 1
      }
      """
