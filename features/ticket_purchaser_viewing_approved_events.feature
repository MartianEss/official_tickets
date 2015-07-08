Feature: Viewing Approved events
  As a potential ticket purchaser
  I want to be able to view approved events
  So that I can purchase tickets for then

  Scenario: Viewing approved events
    Given I am on the events page
    And I am an verified event manager
    And there are 10 approved events
    And there are 5 unapproved events
    When I am on the events page
    Then I should see 10 events
