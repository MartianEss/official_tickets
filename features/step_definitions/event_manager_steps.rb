Given(/^that I am on the events manager sign up page$/) do
  visit new_event_manager_registration_path
end

Given(/^I am an verified event manager$/) do
  EventManager.create!(
    first_name: 'Scooby',
    last_name: 'Dpp',
    contact_number: '0202 222 2222',
    email: 'y@me.com',
    password: 'snoopy23',
    password_confirmation: 'snoopy23',
    approved: true
  )
end

Given(/^I am an unverified event manager$/) do
  EventManager.create!(
    first_name: 'Scooby',
    last_name: 'Dpp',
    contact_number: '0202 222 2222',
    email: 'y@me.com',
    password: 'snoopy23',
    password_confirmation: 'snoopy23'
  )
end

Given(/^I am signed in as a verified event manager$/) do
  step %{I am an verified event manager}
  step %{I sign in as an event manager}
end

When(/^I fill in the following event information:$/) do |table|
   table.rows_hash.each_pair do |input, value|
     fill_in input, with: value
   end
end

When(/^I create my account$/) do
  click_button 'Sign up'
end

When(/^I sign in as an event manager$/) do
  visit new_event_manager_session_path

  fill_in :event_manager_email, with: 'y@me.com'
  fill_in :event_manager_password, with: 'snoopy23'

  click_button 'Log in'
end

Then(/^I should not be signed in to my account$/) do
  expect(body).not_to have_content 'Signed in successfully.'
end

Then(/^I should be signed in to my account$/) do
  expect(body).to have_content 'Signed in successfully.'
end

Then(/^I should have an unverified account$/) do
  expect(EventManager.last).to be_unapproved
end
