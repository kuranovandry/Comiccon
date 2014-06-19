Given(/^I have added all books to cart$/) do
  add_books_to_cart(@books)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I visit the Orders link$/) do
  visit orders_path
end

Then(/^I should see my past order list$/) do
  page.should have_content("past orders")
  page.should have_selector(".orders")
end

Then(/^I should see my new order at the top of the list with order information and book list$/) do
  total_amount = 0
  within page.first(".order") do
    page.should have_selector("tr.order-line", count: @books.count)
    @books.each do |book|
      page.should have_link(book.title)
      total_amount += book.unit_price
    end
    page.should have_content("my address")
    page.should have_content(total_amount)
  end
end