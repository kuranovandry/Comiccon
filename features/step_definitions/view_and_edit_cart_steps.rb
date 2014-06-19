When(/^I visit the cart link$/) do
  visit carts_path
end

When(/^I change quantity of book (\d+) to (\d+)$/) do |book_index, quantity|
  page.all("input#quantities_")[book_index.to_i - 1].set(quantity)
end

Then(/^I should see "(.*?)" link on book (\d+)$/) do |link, book_index|
  within page.all("tr.cart-item-row")[book_index.to_i - 1] do
    page.should have_link(link)
  end
end

When(/^I click on "(.*?)" link on book (\d+)$/) do |link, book_index|
  within page.all("tr.cart-item-row")[book_index.to_i - 1] do
    click_on link
  end
end

And(/^I should not see "(.*?)"$/) do |content|
  page.should_not have_content(content)
end

And(/^I should not see "(.*?)" button$/) do |button|
  page.should_not have_button(button)
end