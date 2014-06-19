Feature:
  As a forgetful user,
  I want to reset my password via email

  Background:
    Given I have an activated account

  Scenario: User resets password via email successfully
    When I visit the Sign in link
    Then I should see "Forgot your password" link
    When I click on "Forgot your password" link
    Then I should see "Forgot your password?"
    When I fill in my email
      And I click on "Send me reset password instructions" button
    Then I should see "You will receive an email with instructions on how to reset your password"
    And I should receive a reset password instructions email
    When I click on the reset password link in the reset password email
    Then I should see "Change your password"
    When I fill in new password and password confirmation correctly
    And I click on "Change my password" button
    Then I should see "Your password was changed successfully"
    And I should be signed in