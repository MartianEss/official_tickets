Given(/^I am on the events page$/) do
  visit events_path
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

Then(/^I should see (\d+) events$/) do |amount|
  expect(page).to have_selector('tr.event', count: amount.to_i)
end
