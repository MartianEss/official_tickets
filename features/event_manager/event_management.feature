Feature: Creating a new account
  As a event manager
  I want to be able to sign up and store my event details

  @wip
  Scenario: Creating an event
    Given the event manager is on the "New Events" page
    And the user is already logged in
    And I am on the "New Event" page
    When I fill in the following events information:
      | field             | value                            |
      | event             | Offical Events Opening           |
      | iamge             | location_to_flyer                |
      | description       | some information about the event |
      | location          | Brighton                         |
      | genre             | Breaks                           |
      | dress_code        | Casual                           |
      | date_from         | 23-03-2020                       |
      | date_to           | 23-03-2020                       |
      | time_to           | 1100                             |
      | time_from         | 2100                             |
      | contact_number    | 0208 222 2222                    |
      | ticket_type       | VIP                              |
      | price             | 24.00                            |
      | tickets allocated | 100                              |
    And I add the following DJs:
      | name      |
      | Ed Solo   |
      | DJ Semtex |
    And I submit the event
    Then the event should be in the "Unavailable" state

  @wip
  Scenario: The event manager is a new user
    Given the event manager is on the "New Events" page
    And they are not signed up
    When I add a new event
    Then they are prompted to create a new account or sign in

  @wip
  Scenario: The event manager is an existing user
    Given the event manager is on the "New Events" page
    And the user is signed signed up already
    When I add a new event
    Then they are prompted to create a new account or sign in

  @wip
  Scenario: The event manager is already logged in
    Given the event manager is on the "New Events" page
    And the user is already logged in
    When I add a new event
    Then the user should be on the "New Event" page

  @wip
  Scenario Outline: Event fields that require verification
    Given I am an event manager
    And I have a verified event
    When I fill in "<field>" with "<value>"
    And I update the event
    Then the event should be updated
    And the event should be unavailable
    And a notification is sent out to customer services

    Examples: Fields that require verification
      | field    | value      |
      | date     | 23-01-2050 |
      | location | Brixton    |

  @wip
  Scenario Outline: Event fields that require no verification
    Given I am an event manager
    And I have a verified event
    When I fill in "<field>" with "<value>"
    And I update the event
    Then the event should be updated
    And the event should still be available
