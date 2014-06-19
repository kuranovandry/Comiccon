When(/^I visit the Home page$/) do
  visit root_path
end

Given(/^there is (\d+) books with "(.*?)" containing "(.*?)" in each category$/) do |book_count, field, value|
  @categories.each do |category|
    update_books(category, book_count.to_i, field, value)
  end
end

When(/^I enter search box with "(.*?)"$/) do |keyword|
  fill_in "query", with: keyword
end

Then(/^I should see (\d+) books with "(.*?)" containing "(.*?)"$/) do |book_count, field, value|
  page.should have_content("Found #{book_count} book")
  page.all(".book-item").count.should == book_count.to_i
  all(".book-item-#{field}").each do |item|
    within(item) { page.should have_content value }
  end
end

When(/^I select "(.*?)"$/) do |category|
  select category, from: "category"
end

When(/^I select category (\d+)$/) do |category_index|
  select @categories[category_index.to_i].name, from: "category"
end

Then(/^I should see (\d+) books$/) do |book_count|
  page.should have_content("Found #{book_count} book")
  page.all(".book-item").count.should == book_count.to_i
end