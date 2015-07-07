Given(/^I am signed in as a customer service user$/) do
  custom_service = CustomerService.create!(
    email: 'y@me.com', 
    password: 'fr0d0h23',
    password_confirmation: 'fr0d0h23'
  )
  
  visit new_customer_service_session_path

  fill_in :customer_service_email, with: custom_service.email
  fill_in :customer_service_password, with: 'fr0d0h23'

  click_button 'Log in'
end


Given(/^there is an unverified event manager with the email address "(.*?)"$/) do |email_address|
  EventManager.create!(
    first_name: 'Scooby',
    last_name: 'Dpp',
    contact_number: '0202 222 2222',
    email: email_address,
    password: 'snoopy23',
    password_confirmation: 'snoopy23',
    approved: false
  )
end


Given(/^I am on the events managers page$/) do
  visit customer_services_event_managers_path
end

When(/^I choose the unverified events manager$/) do
  event_manager = EventManager.where(approved: false).first

  visit customer_services_event_manager_path(id: event_manager.id)
end

When(/^I verify the events manager$/) do
  check 'Approved'

  click_button 'Update'
end

Then(/^"(.*?)" is emailed with the subject "(.*?)"$/) do |email_address, subject|
  open_email(email_address)

  expect(current_email.subject).to eq subject
end


Then(/^the events manager with "(.*?)" account is verified$/) do |email_address|
  expect(EventManager.where(email: email_address).last).to be_approved
end
