Feature: Admin interface
  In order to manually manage system resources
  As an user with admin role
  I can access admin page

  Scenario: Normal users cannot view and access admin page
    Given I have an activated account
    And I sign in with valid email and password
    When I visit the Home page
    Then I should not see "Admin" link
    When I visit Admin page
    Then I should see "Permission denied!"
    And I should not see "Site Administration"

  Scenario: Anonymous users are forced to sign in first when visiting admin page
    When I visit the Home page
    Then I should not see "Admin" link
    When I visit Admin page
    Then I should see "You need to sign in or sign up before continuing"
    And I should not see "Site Administration"

  Scenario: Admin user can access admin page
    Given I have an admin account
    And I sign in with valid email and password
    When I visit the Home page
    Then I should see "Admin" link
    When I click on "Admin" link
    Then I should see "Site Administration"