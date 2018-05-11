@domain @api

Feature: List All Tasks for a Project

Scenario: Given a project
When I specify a project
* the project has 5 tasks
Then I get 5 tasks