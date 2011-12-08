# Feature: A user should be able to sign in *interactively* (?)
Feature: A user should be able to sign in

  Scenario: A user who is not logged in should see a login form
    When I am not logged in
    And I visit '/'
    Then I should see the login form

  Scenario: A user who is logged in should not see a login form
    When I am logged in
    And I visit '/'
    Then I should not see the login form

  Scenario: A user should be able to log in
    When I visit '/'
    And I am not logged in
    Then I should see the login form
    And I should be able to log in
