Feature: Creating a new event
  As an approved event manager
  I want to be able to store my event details

  Scenario: Creating an event
    Given I am signed in as a verified event manager
    And I am on the event manager's new events page
    When I fill in the following events information:
      | title             | Offical Events Opening           |
      | description       | some information about the event |
      | location          | Brighton                         |
      | genre             | Breaks                           |
      | dress_code        | Casual                           |
      | date_from         | 23/03/2020                       |
      | date_to           | 23/03/2020                       |
      | time_to           | 11:00                            |
      | time_from         | 21:00                            |
      | contact_number    | 0208 222 2222                    |
      | ticket_type       | VIP                              |
      | price             | 24.00                            |
      | tickets_allocated | 100                              |
    And I submit the event
    Then the event should be awaiting approval

  Scenario Outline: Event fields that require verification
    Given I am signed in as a verified event manager
    And there is 1 verified event
    And I view the last verified event
    When I update the event's "<field>" with "<value>"
    And I update the event
    Then the event should be unavailable

    Examples: Fields that require verification
      | field     | value      |
      | location  | Brixton    |
      | Date from | 23/03/2020 |
      | Date to   | 23/03/2020 |
      | Time to   | 11:00      |
      | Time from | 21:00      |

  Scenario Outline: Event fields that require no verification
    Given I am signed in as a verified event manager
    And there is 1 verified event
    And I view the last verified event
    When I update the event's "<field>" with "<value>"
    And I update the event
    Then the event should still be available

    Examples: Fields that don't require verification
      | field             | value                            |
      | title             | Offical Events Opening           |
      | description       | some information about the event |
      | genre             | Breaks                           |
      | dress_code        | Casual                           |
      | contact_number    | 0208 222 2222                    |

  @wip
  Scenario: The event manager is a new user
    Given the event manager is on the "New Events" page
    Given I am an unverified event manager
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
