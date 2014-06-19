Feature: Rate and comment books
  As an activated user
  I can add rating (1 to 5) and comment to any book once

  Background:
    Given I have an activated account
    And System has a book with 3 comments

  Scenario: Not signed in user cannot comment or rate on book
    When I visit the link of a book
    Then I should not see "comment" box
    And I should not see "rate" box

  Scenario: Signed in user can only comment and rate once
    When I sign in with valid email and password
    And I visit the link of a book
    And I have commented and rated on that book before
    Then I should not see "comment" box
    And I should not see "rate" box

  Scenario: Signed in user can rate and comment on book for the first time
    When I sign in with valid email and password
    And I visit the link of a book
    Then I should see "comment" box
    And I should see "rate" box
    When I comment "My comment" and rate 3
    Then I should see "Comment posted!"
    And I should see "My comment" and rating 3 added at the top of the comment list

  Scenario: User can only rate when also comment
    When I sign in with valid email and password
    And I visit the link of a book
    When I comment "" and rate 3
    Then I should see "Error occured while posting comment, please try again!"