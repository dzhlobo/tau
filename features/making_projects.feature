Feature: Making new projects
  In order to avoid making project directory myself
  As a web developer
  I want tau make project for me

  Scenario: making new project by tau
    When I run `tau new testproject`
    Then the exit status should be 0
    Then there should be right project directory "testproject"
