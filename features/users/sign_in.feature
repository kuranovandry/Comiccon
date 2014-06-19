Feature: Sign in

  Scenario: User signs in successfully
    Given I have an activated account
    When I sign in with valid email and password
    Then I should be signed in
    And I should see "Signed in successfully"

  Scenario: User has not signed up yet
    Given I have not signed up for an account
    When I sign in with valid email and password
    Then I should see "Invalid email or password"
    And I should not be signed in

  Scenario: User account has not been activated yet
    Given I have signed up for a new account
    When I sign in with valid email and password
    Then I should see "You have to confirm your account"
    And I should not be signed in

  Scenario: User signs in with invalid password
    Given I have an activated account
    When I sign in with invalid password
    Then I should see "Invalid email or password"
    And I should not be signed in
