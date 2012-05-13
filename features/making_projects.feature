Feature: Making new projects
  In order to avoid making project directory myself
  As a web developer
  I want tau make project for me

  Scenario: making new project by tau
    When I successfully run `tau new testproject`
    Then there should be right project directory "testproject"

  Scenario: making project with dot in project name
  	When I successfully run `tau new .test.project.`
  	Then there should be right project directory ".test.project."
