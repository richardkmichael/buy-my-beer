Feature: Sign up and login.

  Scenario: A user who is not logged in should see a login form.
    # Given I visit '/'
    # And I am not logged in
    Given I have not logged in
    And I visit '/'
    Then I should see the login form

  Scenario: A user who is logged in should not see a login form.
    # Given I visit '/'
    # And I am logged in
    # Given I do have an account
    Given I have logged in
    And I visit '/'
    Then I should not see the login form

  Scenario: A user who has already logged in does not receive a notification.
    Given I have logged in before
    And I visit '/'
    And I log in again
    Then I should not be told 'An account has been created and confirmation email has been sent to you.'

  Scenario: A user who has never logged in receives a notification.
    Given I have not logged in before
    And I visit '/'
    Then I should be able to log in
    And I should be told 'An account has been created and confirmation email has been sent to you.'
