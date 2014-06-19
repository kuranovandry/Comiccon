Feature: View and edit cart
  As an user
  I want to view and edit quantity of books in cart

  Background:
    Given System has 1 book(s)
    And book 1 has price 10$
    And I have added book 1 to cart

  Scenario: User views cart
    When I visit the cart link
    Then I should see the cart with 1 book(s)
    And I should see book 1 title, author, unit price, quantity = 1
    And I should see total amount equals to 10
    And I should see "Update" button
    And I should see "Remove" link on book 1

  Scenario: User edits book quantity in cart
    When I visit the cart link
    Then I should see total amount equals to 10
    When I change quantity of book 1 to 3
    And I click on "Update" button
    Then I should see total amount equals to 30

  Scenario: User removes a book in cart
    When I visit the cart link
    Then I should see the cart with 1 book(s)
    When I click on "Remove" link on book 1
    Then I should see the cart with 0 book(s)
    And I should not see "Total amount"
    And I should not see "Update" button
    And I should not see "Checkout" button