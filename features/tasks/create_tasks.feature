@domain @api
Feature: Creating tasks

  Rules:
  - Created tasks should default to "in-progress" state


  Scenario: Creating a task with all fields
    When I create a task with:
      | NAME        | Sample Task                          |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | DESCRIPTION | This is a sample task.               |
      | STATE       | done                                 |
    Then the system has the tasks:
      | NAME        | STATE        |PROJECT_ID                            |DESCRIPTION |
      | Sample Task | done         |54f8419c-3f22-4cba-b194-5f8b4727ccfd  |This is a sample task. |

  Scenario: Task created with in-progress state as default
    When I create a task with:
      | NAME        | Sample Task                          |
      | PROJECT_ID  | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | DESCRIPTION | This is a sample task.               |
    Then the system has the tasks:
      | NAME        | STATE        |PROJECT_ID                            |DESCRIPTION |
      | Sample Task | in_progress  |54f8419c-3f22-4cba-b194-5f8b4727ccfd  |This is a sample task. |

