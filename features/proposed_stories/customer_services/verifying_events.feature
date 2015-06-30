Feature: Verifying Events
  As a customer service user
  I should be able to verify events and thier managers

  @wip
  Scenario: Event Manager verification
    Given I am signed in as a customer service usea
    And there is an unverified event manager
    And I am on the events managers page
    When I choose the unverified events manager
    And I verify the events manager
    Then the events manager is emailed
    And the events manager's account is verified
    
  @wip
  Scenario: Event verification
    Given I am signed in as a customer service user
    And there is an unverified event
    And I am on the events verification page
    When I choose the unverified event
    And I verify the event
    Then the event should be available for ticket purchases
