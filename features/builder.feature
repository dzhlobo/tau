Feature: Builder
  In order to avoid compiling all files by hand
  As a web developer
  I want tau compile all files for me

  Background: making project
    Given I successfully run `tau new project2build`
    And I cd to "project2build"

  Scenario: building project
    Given a file named "code/hamltest.haml" with:
      """
      %h1 Hello, world!
      %strong I'm tau ;)
      """
    And a file named "code/js/coffeetest.coffee" with:
      """
      square = (x) -> x * x
      cube   = (x) -> square(x) * x
      """
    And a file named "code/css/sasstest.sass" with:
      """
      $blue: #3bbfce
      .content-navigation
        border-color: $blue
        color: darken($blue, 9%)
      """
    And a file named "code/css/scsstest.scss" with:
      """
      $blue: #3bbfce;
      .content-navigation {
        border-color: $blue;
        color:
          darken($blue, 9%);
      }
      """
    When I successfully run `tau build`
    Then I should see file "build/hamltest.html" compiled from haml in "code/hamltest.haml"
    And I should see file "build/js/coffeetest.js" compiled from coffee-script in "code/js/coffeetest.coffee"
    And I should see file "build/css/sasstest.css" compiled from sass in "code/css/sasstest.sass"
    And I should see file "build/css/scsstest.css" compiled from scss in "code/css/scsstest.scss"
