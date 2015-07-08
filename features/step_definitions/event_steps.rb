When(/^I fill in the following events information:$/) do |table|
  value = table.rows_hash

  fill_in "event_title", with: value[:title]
  fill_in "event_description", with: value[:description]
  fill_in "event_location", with: value[:location]
  fill_in "event_genre", with: value[:genre]
  fill_in "event_dress_code", with: value[:dress_code]

  select_date value[:date_from], label: "Date from"
  select_date value[:date_to], label: "Date to"

  select_time value[:time_from], label: "Time from"
  select_time value[:time_to], label: "Time to"

  fill_in "event_contact_number", with: value[:contact_number]

  fill_in "event_ticket_type", with: value[:ticket_type]
  fill_in "event_price", with: value[:price]
  fill_in "event_tickets_allocated", with: value[:tickets_allocated]
end

When(/^I submit the event$/) do
  click_button 'Create Event'
end

Then(/^the event should be awaiting approval$/) do
  expect(Event.last).to be_unapproved
end
