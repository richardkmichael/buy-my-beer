Feature: Login for all users

  Scenario: The login form should be seen unless logged in
    Given I am not logged in
    When I visit '/'
    Then I should see the login form

  Scenario: A logged in user should not see the login form
    Given I am logged in
    When I visit '/'
    Then I should not see the login form

  Scenario: A user who has previously logged in does not receive a new user notification
    Given I am logged in
    Then I log out
    When I log in again
    And I should not be told 'Welcome to Buy My Beer a confirmation email has been sent to you.'

  Scenario: A user who has never logged in receives a notification
    Given I have never logged in
    When I log in
    Then I should be told 'Welcome to Buy My Beer a confirmation email has been sent to you.'
