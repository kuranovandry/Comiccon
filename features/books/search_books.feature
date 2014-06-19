@search
Feature: Search for books
  As an anonymous user
  I want to search for books by (part of) book title, author name, category

  Background:
    Given System has 2 categories, each has 5 books
    And there is 1 books with "title" containing "interesting book" in each category
    And there is 1 books with "author_name" containing "arthur" in each category
    And I visit the Home page

  Scenario: User searches for books by book title with "All categories" chosen
    When I enter search box with "interest"
    And I select "All categories"
    And I click on "Search" button
    Then I should see 2 books with "title" containing "interesting book"

  Scenario: User searches for books by book title with category 1 chosen
    When I enter search box with "interest"
    And I select category 1
    And I click on "Search" button
    Then I should see 1 books with "title" containing "interesting book"

  Scenario: User searches for books by author name with "All categories" chosen
    When I enter search box with "arthu"
    And I select "All categories"
    And I click on "Search" button
    Then I should see 2 books with "author" containing "arthur"

  Scenario: User searches for books by author name with category 1 chosen
    When I enter search box with "arthu"
    And I select category 1
    And I click on "Search" button
    Then I should see 1 books with "author" containing "arthur"

  Scenario: User searches without keyword and with "All categories" chosen
    When I select "All categories"
    And I click on "Search" button
    Then I should see 10 books

  Scenario: User searches without keyword and with category 1 chosen
    When I select category 1
    And I click on "Search" button
    Then I should see 5 books

  Scenario: No book matches keyword
    When I enter search box with "nobook"
    And I click on "Search" button
    Then I should see 0 books