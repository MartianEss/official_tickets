Feature: Purchasing tickets
  As a ticket purchaser
  I want to be able to purhcase tickets for an event

  @wip
  Scenario: Purchasing a ticket 
    Given I am not an existing ticket purchaser
    And there is a verified event
    When I am on the events page
    And I want to buy 3 tickets
    Then I should have to enter 3 names
    When I purchase the tickets
    Then I should receive an email with the tickets and confirmation

  @wip
  Scenario: Purchasing tickets as a new user
    Given I am not an existing ticket purchaser
    And there is a verified event
    When I am on the events page
    And I want to buy a ticket
    Then I should be redirected to sign up
    When I have successfully signed up
    Then I should be redirected to the purchase ticket page

  @wip
  Scenario: purchasing tickets as an existing user
    Given I am an existing ticket purchaser
    And there is a verified event
    When I am on the events page
    And I want to buy a ticket
    Then I should be able to purchase a ticket
    And the ticket should be emailed to my email account
