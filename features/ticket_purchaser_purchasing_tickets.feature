Feature: Purchasing tickets
  As a ticket purchaser
  I want to be able to purhcase tickets for an event

  @wip
  Scenario: Purchasing a ticket 
    Given an event manager has 1 approved event
    And I am signed in as a ticket purchaser
    When I view the event
    And choose to buy tickets
    And I want 3 tickets
    And I purchase the tickets
    Then I should receive an email with the tickets and confirmation
