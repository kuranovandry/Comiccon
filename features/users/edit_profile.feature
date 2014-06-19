Feature: Edit user profile
  In order to update my profile information
  As a registered user
  I want to edit my user profile

    Background:
      Given I have an activated account
      And I sign in with valid email and password
      And I visit Edit Profile link

    Scenario: User edits email unsuccessfully without entering current password
      When I enter "Email" field with "newemail@example.com"
      And I click on "Update" button
      Then I should see "Current password can't be blank"

    Scenario: User edits email successfully
      When I enter "Email" field with "newemail@example.com"
      And I enter "Current password" field with "password"
      And I click on "Update" button
      Then I should receive a confirmation email sent to "newemail@example.com"
      When I click on the confirmation link in the confirmation email
      And I should see "Your account was successfully confirmed"
      And I should be signed in

    Scenario: User edits password unsuccessfully when not matching password confirmation
      When I enter "Password" field with "newpassword"
      And I enter "Password confirmation" field with "wrongconfirmation"
      And I click on "Update" button
      Then I should see "Password confirmation doesn't match Password"

    Scenario: User edits password unsuccessfully without entering current password
      When I enter "Password" field with "newpassword"
      And I enter "Password confirmation" field with "newpassword"
      And I click on "Update" button
      Then I should see "Current password can't be blank"

    Scenario: User edits password successfully
      When I enter "Password" field with "newpassword"
      And I enter "Password confirmation" field with "newpassword"
      And I enter "Current password" field with "password"
      And I click on "Update" button
      Then I should see "You updated your account successfully"

    Scenario: User edits full name, birthday, phone successfully without the need for current password
      When I enter "Full name" field with "New name"
      And I enter "Phone" field with "9876543"
      And I enter "Birthday" field with "11/11/1111"
      And I click on "Update" button
      Then I should see "You updated your account successfully"