Feature: Verifying Events
  As a customer service user
  I should be able to verify events and thier managers

  Scenario: Event Manager verification
    Given I am signed in as a customer service user
    And there is an unverified event manager with the email address "y@me.com"
    When I choose the unverified events manager
    And I verify the events manager
    Then "y@me.com" is emailed with the subject "Your account has been approved"
    And the events manager with "y@me.com" account is verified
    
  @wip
  Scenario: Event verification
    Given I am signed in as a customer service user
    And there is an unverified event
    And I am on the events verification page
    When I choose the unverified event
    And I verify the event
    Then the events manager is emailed with the subject "You've event has been approved"
    Then the event should be available for ticket purchases
