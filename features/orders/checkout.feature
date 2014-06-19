Feature:
  As an user
  I want to checkout while browsing the shopping cart page

  Background:
    Given I have an activated account
    And System has 1 book(s)
    And I have added all books to cart

  Scenario: Signed in user can checkout from cart page
    Given I sign in with valid email and password
    When I visit the cart link
    Then I should see "Checkout" button
    When I click on "Checkout" button
    Then I should see "Confirm order"
    When I fill in "order[shipping_address]" with "my address"
    And I click on "Confirm" button
    Then I should see "Order is confirmed successfully!"
    And I should see my past order list
    And I should see my new order at the top of the list with order information and book list

  Scenario: Anonymous user is forced to sign in before checkout
    When I visit the cart link
    Then I should see "Checkout" button
    When I click on "Checkout" button
    Then I should see "You need to sign in or sign up before continuing"
    When I sign in with valid email and password
    Then I should see "Confirm order"

  Scenario: Signed in user can view past orders
    Given I sign in with valid email and password
    Then I should see "Orders" link
    When I visit the Orders link
    Then I should see my past order list

  Scenario: Anonymous user is forced to sign in before viewing past orders
    When I visit the Home page
    Then I should not see "Orders" link
    When I visit the Orders link
    Then I should see "You need to sign in or sign up before continuing"
    When I sign in with valid email and password
    Then I should see my past order list