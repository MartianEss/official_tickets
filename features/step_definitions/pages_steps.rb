Given(/^I am on the event manager's new events page$/) do
  visit new_event_managers_event_path
end

Given(/^I view the last verified event$/) do
  event = Event.where(approved: true).last

  visit edit_event_managers_event_path(id: event.id)
end

When(/^I view the event$/) do
  event = Event.where(approved: true).last

  visit event_path(id: event)
end

Then(/^I should be redirected to the purchase ticket page$/) do
  pending # express the regexp above with the code you wish you had
end
