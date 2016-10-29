@domain @api
Feature: Listing tasks

  Rules:
  - if a negative page is requested, an error is thrown
  - if a page that is too high is requested, the last page is returned
  - if a negative page_size is requested, the default size is used


  Scenario: No parameters are specified and there are 26 tasks
    Given 26 tasks
    When I request the tasks list
    Then I get 25 tasks back
    And the current page is 1
    And the total pages is 2
    And the total results is 26


  Scenario: Specifying parameters for the last tasks page
    Given 3 tasks
    When I request the tasks list with parameters:
      | PAGE_SIZE | 2 |
      | PAGE      | 2 |
    Then I get 1 task back
    And the current page is 2
    And the total pages is 2
    And the total results is 3


  Scenario: The specified page is outside of the acceptable range
    Given 3 tasks
    When I request the tasks list with parameters:
      | PAGE_SIZE | 2 |
      | PAGE      | 5 |
    Then I get 1 task back
    And the current page is 2
    And the total pages is 2
    And the total results is 3


  Scenario: The specified page size is greater than the number of tasks
    Given 2 tasks
    When I request the tasks list with parameters:
      | PAGE_SIZE | 10 |
      | PAGE      | 1  |
    Then I get 2 tasks back
    And the current page is 1
    And the total pages is 1
    And the total results is 2


  Scenario: The specified page is negative
    Given 2 tasks
    When I request the tasks list with parameters:
      | PAGE | -1 |
    Then I get the error "Page cannot be <= 0"


  Scenario: Verifying the format shape
    Given a task:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Task                          |
      | DESCRIPTION | A small sample task                  |
      | STATE       | todo                                 |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    When I request the tasks list
    Then I get the data:
      """
      {
        tasks: [
          {
            id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd',
            name: 'Sample Task',
            description: 'A small sample task',
            state: 'todo',
            project_id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd'
          }
        ],
        count: 1,
        current_page_number: 1,
        total_page_count: 1
      }
      """
