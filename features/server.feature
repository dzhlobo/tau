Feature: Server
  In order to compile all files by hand
  As a web developer
  I want tau server do it for me

  Background: changing directory
    Given I'm on sandbox project directory

  Scenario: runtime haml compilation
    Given a file named "code/hamltest.haml" with:
      """
      %h1 Hello, world!
      %strong I'm tau ;)
      """
    When I go in browser to "http://localhost:15000/hamltest.html"
    Then I should see html compiled from haml in "code/hamltest.haml"

  Scenario: runtime coffee-script compilation
    Given a file named "code/js/coffeetest.coffee" with:
      """
      square = (x) -> x * x
      cube   = (x) -> square(x) * x
      """
    When I go in browser to "http://localhost:15000/js/coffeetest.js"
    Then I should see js compiled from coffee-script in "code/js/coffeetest.coffee"

  Scenario: runtime sass compilation
    Given a file named "code/css/sasstest.sass" with:
      """
      $blue: #3bbfce
      .content-navigation
        border-color: $blue
        color: darken($blue, 9%)
      """
    When I go in browser to "http://localhost:15000/css/sasstest.css"
    Then I should see css compiled from sass in "code/css/sasstest.sass"

  Scenario: runtime scss compilation
    Given a file named "code/css/scsstest.scss" with:
      """
      $blue: #3bbfce;
      .content-navigation {
        border-color: $blue;
        color:
          darken($blue, 9%);
      }
      """
    When I go in browser to "http://localhost:15000/css/scsstest.css"
    Then I should see css compiled from scss in "code/css/scsstest.scss"
