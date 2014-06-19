Then(/^I should not see "(.*?)" box$/) do |tool|
  page.should_not have_selector(".#{tool}-box")
end

Then(/^I should see "(.*?)" box$/) do |tool|
  page.should have_selector(".#{tool}-box")
end

Given(/^I have commented and rated on that book before$/) do
  comment_rate("My first comment", 3)
end

When(/^I comment "(.*?)" and rate (\d+)$/) do |comment, rate|
  comment_rate(comment, rate.to_i)
end

Then(/^I should see "(.*?)" and rating (\d+) added at the top of the comment list$/) do |comment, rating|
  within page.first(".comment") do
    page.should have_content(comment)
    page.should have_content(rating)
    page.should have_content(@user.full_name)
  end
end