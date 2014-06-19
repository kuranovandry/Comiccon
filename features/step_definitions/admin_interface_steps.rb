Then(/^I should see "(.*?)" link$/) do |link|
  page.should have_link(link)
end

Then(/^I should not see "(.*?)" link$/) do |link|
  page.should_not have_link(link)
end

When(/^I visit Admin page$/) do
  visit rails_admin_path
end

Given(/^I have an admin account$/) do
  @user = FactoryGirl.create(:admin)
end

When(/^I click on "(.*?)" link$/) do |link|
  click_link link
end