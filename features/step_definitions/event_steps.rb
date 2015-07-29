When(/^I fill in the following events information:$/) do |table|
  value = table.rows_hash

  fill_in "event_title", with: value[:title]
  fill_in "event_description", with: value[:description]
  fill_in "event_address_line1", with: value[:location]
  fill_in "event_town_city", with: value[:town_city]
  fill_in "event_post_code", with: value[:post_code]
  fill_in "event_genre", with: value[:genre]
  fill_in "event_dress_code", with: value[:dress_code]

  select_date value[:date_from], label: "Date from"
  select_date value[:date_to], label: "Date to"

  select_time value[:time_from], label: "Time from"
  select_time value[:time_to], label: "Time to"

  fill_in "event_contact_number", with: value[:contact_number]
end

Given(/^there is (\d+) unverified event$/) do |amount|
  event_manager = EventManager.where(approved: true).first

  amount.to_i.times do
    event_manager.events.create!(event_params(approved: false))
  end
end

Given(/^there is (\d+) verified event$/) do |amount|
  event_manager = EventManager.where(approved: true).first

  amount.to_i.times do
    event_manager.events.create!(event_params(approved: true))
  end
end

When(/^I submit the event$/) do
  click_button 'Create Event'
end

When(/^I update the event's "(.*?)" with "(.*?)"$/) do |input, value|
  if input.include?('Date')
    select_date value, label: input
  elsif input.include?('Time')
    select_time value, label: input
  else
    fill_in "event_#{input}", with: value
  end
end

When(/^I update the event$/) do
  click_button 'Update Event'
end

Then(/^the event should be awaiting approval$/) do
  expect(Event.last).to be_unapproved
end

Then(/^the event should be unavailable$/) do
  step %{the event should be awaiting approval}
end


Then(/^the event should still be available$/) do
  expect(Event.last).to be_approved
end
