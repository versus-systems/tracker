@domain @api
Feature: Listing tasks

  Rules:
  - if a blank project id is requested, an error Project not found,is thrown
  - if a project that has no tasks is requested, an empty array of tasks is returned
  - if a task that doesn't exists or task id empty is requested ,an error "Task not found" is thrown


  Scenario: Retrieving project tasks
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given the following tasks:
      | ID                                   | NAME        | STATE        | PROJECT_ID                            | DESCRIPTION |
      | 54f8419a-3f21-4cba-b195-5f8b4727ccfe | Task one       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccff | Task two       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccgg | Different Task | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfdaa  | A different project task|

    When I request the tasks list of project:
      | PROJECT_ID | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then I get the data:
    """
      {
        tasks: [
          {
            id: '54f8419a-3f21-4cba-b195-5f8b4727ccfe',
            project_id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd',
            name: 'Task one',
            description: 'A small task',
            state: 'in_progress'
          },
           {
            id: '54f8419b-3f23-4cba-b196-5f8b4727ccff',
            project_id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd',
            name: 'Task two',
            description: 'A small task',
            state: 'in_progress'
          }
        ],
        count: 2,
        current_page_number: 1,
        total_page_count: 1
      }
      """
  Scenario: Fetching project tasks that has none
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given the following tasks:
      | ID                                   | NAME        | STATE        | PROJECT_ID                            | DESCRIPTION |
      | 54f8419a-3f21-4cba-b195-5f8b4727ccfe | Task one       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccff | Task two       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccgg | Different Task | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfdaa  | A different project task|

    When I request the tasks list of project:
      | PROJECT_ID | 12f8419c-3f22-4cba-b194-5f8b4727ccf |
    Then I get the data:
    """
      {
        tasks: [],
        count: 0,
        current_page_number: 0,
        total_page_count: 0
      }
      """
  Scenario: Fetching tasks with blank project id
    Given a project:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given the following tasks:
      | ID                                   | NAME        | STATE        | PROJECT_ID                            | DESCRIPTION |
      | 54f8419a-3f21-4cba-b195-5f8b4727ccfe | Task one       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccff | Task two       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccgg | Different Task | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfdaa  | A different project task|

    When I request the tasks list of project:
      | PROJECT_ID |  |
    Then I get the error "Project not found"


  Scenario: Request a task by task id
    Given a task:
      | ID          | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | PROJECT_ID  | 54f8419a-3f21-4cbb-b195-5f8b4727ccfe |
      | NAME        | Sample Task                          |
      | DESCRIPTION | A small sample task                  |
      | STATE       | in_progress                          |
    When I request a task:
      | ID | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
    Then I get the data:
      """
      {
        id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd',
        project_id: '54f8419a-3f21-4cbb-b195-5f8b4727ccfe',
        name: 'Sample Task',
        description: 'A small sample task',
        state: 'in_progress'
      }
      """
  Scenario: Request a task by task id, where task id doesn't exists
    Given the following tasks:
      | ID                                   | NAME        | STATE        | PROJECT_ID                            | DESCRIPTION |
      | 54f8419a-3f21-4cba-b195-5f8b4727ccfe | Task one       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccff | Task two       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccgg | Different Task | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfdaa  | A different project task|

    When I request a task:
      | ID | 54f8419c-3f22-4cba-b194-5f8b4727ccfdsss |
    Then I get the error "Task not found"

  Scenario: Request a task by task id, where task id is empty
    Given the following tasks:
      | ID                                   | NAME        | STATE        | PROJECT_ID                            | DESCRIPTION |
      | 54f8419a-3f21-4cba-b195-5f8b4727ccfe | Task one       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccff | Task two       | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd  | A small task|
      | 54f8419b-3f23-4cba-b196-5f8b4727ccgg | Different Task | in_progress  | 54f8419c-3f22-4cba-b194-5f8b4727ccfdaa  | A different project task|

    When I request a task:
      | ID |  |
    Then I get the error "Task not found"
