Feature: Add book to cart
  In order to collect books I want to buy
  As an anonymous user
  I want to add books to cart

  Background:
    Given System has 2 book(s)
    And book 1 has price 10$
    And book 2 has price 20$

  Scenario: User adds a book to cart
    When I visit the link of book 1
    When I click on Add to cart button
    Then I should see the cart with 1 book(s)
    And I should see book 1 title, author, unit price, quantity = 1
    And I should see total amount equals to 10

  Scenario: User adds multiple books to cart
    Given I have added book 1 to cart
    When I visit the link of book 2
    When I click on Add to cart button
    Then I should see the cart with 2 book(s)
    And I should see book 1 title, author, unit price, quantity = 1
    And I should see book 2 title, author, unit price, quantity = 1
    And I should see total amount equals to 30

  Scenario: User adds a book to cart twice
    Given I have added book 1 to cart
    When I visit the link of book 1
    When I click on Add to cart button
    Then I should see the cart with 1 book(s)
    And I should see book 1 title, author, unit price, quantity = 2
    And I should see total amount equals to 20