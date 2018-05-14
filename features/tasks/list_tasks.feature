@domain @api

Feature: List All Tasks for a Project

Scenario: Given a project
When I go to the project path
* the project has 5 tasks
Then I see 5 tasks