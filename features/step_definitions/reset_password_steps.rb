When(/^I visit the Sign in link$/) do
  visit new_user_session_path
end

When(/^I fill in my email$/) do
  fill_in "Email", with: @user.email
end

Then(/^I should receive a reset password instructions email$/) do
  unread_emails_for(@user.email).size.should > 0
  open_email(@user.email)
end

When(/^I click on the reset password link in the reset password email$/) do
  click_first_link_in_email
end

When(/^I fill in new password and password confirmation correctly$/) do
  fill_in "New password", with: "newpassword"
  fill_in "Confirm new password", with: "newpassword"
end