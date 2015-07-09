Given(/^I am on the events page$/) do
  visit events_path
end


Given(/^I am signed in as a ticket purchaser$/) do
  password = Faker::Internet.password

  ticket_purchaser = TicketPurchaser.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )

  visit new_ticket_purchaser_session_path

  fill_in :ticket_purchaser_email, with: ticket_purchaser.email
  fill_in :ticket_purchaser_password, with: ticket_purchaser.password

  click_button 'Log in'
end

Given(/^there are (\d+) approved events$/) do |amount|
  event_manager = EventManager.where(approved: true).first

  amount.to_i.times do
    event_manager.events.create!(event_params(approved:true))
  end
end

Given(/^there are (\d+) unapproved events$/) do |amount|
  event_manager = EventManager.where(approved: true).first

  amount.to_i.times do
    event_manager.events.create!(event_params)
  end
end

When(/^choose to buy tickets$/) do
  click_link 'Purchase'
end

When(/^I want (\d+) tickets$/) do |amount|
  fill_in :order_number_of_tickets, with: amount
end

When(/^I purchase the tickets$/) do
  click_button 'Create Order'
end

Then(/^I should receive an email with the tickets and confirmation$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see (\d+) events$/) do |amount|
  expect(page).to have_selector('tr.event', count: amount.to_i)
end
