Feature: Login for all users.

  Scenario: A user who is not logged in should see a login form.
    Given I have not logged in
    When I visit '/'
    Then I should see the login form

  Scenario: A user who is logged in should not see a login form.
    Given I have logged in
    When I visit '/'
    Then I should not see the login form

  Scenario: A user who has already logged in does not receive a notification.
    Given I have logged in
    When I log out
    # And I visit '/'
    And I log in again
    Then I should not be told 'An account has been created and confirmation email has been sent to you.'

  Scenario: A user who has never logged in receives a notification.
    Given I have not logged in before
    And I visit '/'
    Then I should be able to log in
    And I should be told 'An account has been created and confirmation email has been sent to you.'

# PRESENT TENSE ----
#
# Scenario: A user who is not logged in should see a login form.
#   When I do not log in
#   And I visit '/'
#   Then I should see the login form

# Scenario: A user who is logged in should not see a login form.
#   When I log in
#   And I visit '/'
#   Then I should not see the login form

# Scenario: A user who has already logged in does not receive a notification.
#   When I log in
#   Then I log out
#   When I log in again
#   Then I should not be told 'An account has been created and confirmation email has been sent to you.'

# Scenario: A user who has never logged in receives a notification.
#   When I log in for the first time
#   Then I should be told 'An account has been created and confirmation email has been sent to you.'
