Given(/^System has (\d+) book\(s\)$/) do |book_count|
  @books = FactoryGirl.create_list(:book, book_count.to_i)
end

When(/^I visit the link of book (\d+)$/) do |book_index|
  visit book_path(@books[book_index.to_i - 1])
end

When(/^book (\d+) has price (\d+)\$$/) do |book_index, price|
  @books[book_index.to_i - 1].update_attribute(:unit_price, price.to_f)
end

Then(/^I should see "(.*?)" button$/) do |button|
  page.should have_button(button)
end

When(/^I click on Add to cart button$/) do
  find("#add-to-cart-btn").click
end

Then(/^I should see the cart with (\d+) book\(s\)$/) do |book_count|
  page.should have_selector("tr.cart-item-row", count: book_count.to_i)
end

Then(/^I should see book (\d+) title, author, unit price, quantity = (\d+)$/) do |book_index, quantity|
  book = @books[book_index.to_i - 1]
  page.should have_content(book.title)
  page.should have_content(book.author_name)
  page.should have_content(book.unit_price)
  page.all("input#quantities_")[book_index.to_i - 1][:value].should eq quantity
end

Then(/^I should see total amount equals to (\d+)$/) do |amount|
  within("#total-amount-value") do
    page.should have_content(amount)
  end
end

Given(/^I have added book (\d+) to cart$/) do |book_index|
  visit book_path(@books[book_index.to_i - 1])
  find("#add-to-cart-btn").click
end