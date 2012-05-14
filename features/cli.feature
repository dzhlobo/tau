Feature: Cli
  As a tau user
  I should be able to see usage information

  Scenario: viewing help by default
    When I run `tau`
    Then I should see usage information

  Scenario: viewing help
    When I run `tau --help`
    Then I should see usage information

  Scenario: tau commands should be described
    When I run `tau --help`
    Then I should see commands described:
      | help   |
      | new    |
      | server |

  Scenario: viewing version of tau
    When I run `tau -v`
    Then I should see version
