Feature: Sign up and login.

  Scenario: I should be able to login on the home page.
    When I visit '/'
    And I am not logged in
    Then I should see the login form

  Scenario: A user who is logged in should not see a login form
    When I visit '/'
    And I am logged in
    Then I should not see the login form

  Scenario: A user without an account may log in.
    When I login
    And I do not have an account
    Then I should be able to log in
    And I am told I will receive a confirmation email

  Scenario: A user with an existing account may log in.
    When I login
    And I do have an account
    Then I should be able to log in
