Feature: Ticket type creation
  In order to be able to see tickets for an event I manage
  As an event manager
  I should be able to create varying ticket types for an event

  @wip
  Scenario: Navigating to the events ticket creation page
    Given I am an existing event manager
    And I have an event
    When I am on the event's new ticket type page
    Then I should see a form will have the following fields:
      | name              | Early Bird        |
      | price             | price             |
      | number_of_tickets | number of tickets |
