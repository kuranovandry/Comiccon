Given(/^System has (\d+) categories, each has (\d+) books$/) do |category_count, book_count|
  @categories ||= FactoryGirl.create_list(:category_with_books, category_count.to_i, book_count: book_count.to_i)
end

When(/^I visit the Categories page$/) do
  visit categories_path
end

Then(/^I should see the links to all categories listed$/) do
  @categories.each do |category|
    page.should have_link category.name
  end
end

When(/^I visit category (\d+) link$/) do |category_index|
  visit category_path(@categories[category_index.to_i])
end

Then(/^I should see book (\d+) to (\d+) of category (\d+)$/) do |book_index_from, book_index_to, category_index|
  category = @categories[category_index.to_i]
  books = category.books[(book_index_from.to_i - 1)..(book_index_to.to_i - 1)]
  books.each do |book|
    page.should have_link book.title
  end
end

Then(/^I should see page (\d+) for the other books$/) do |page_no|
  page.should have_link page_no
end

When(/^I click on page (\d+)$/) do |page_no|
  click_link page_no
end