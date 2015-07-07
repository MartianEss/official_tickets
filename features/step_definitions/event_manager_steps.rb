Given(/^that I am on the events manager sign up page$/) do
  visit new_event_manager_registration_path
end

When(/^I fill in the following event information:$/) do |table|
   table.rows_hash.each_pair do |input, value|
     fill_in input, with: value
   end
end

When(/^I create my account$/) do
  click_button 'Sign up'
end

Then(/^I should have an unverified account$/) do
  expect(EventManager.last).to be_unapproved
end
