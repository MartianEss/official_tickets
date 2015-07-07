Feature: Creating a new account
  As a event manager
  I want to be able to sign up and store my event details

  Scenario: Creating an event manager account
    Given that I am on the events manager sign up page
    When I fill in the following event information:
      | First name            | joe                       |
      | Last name             | smith                     |
      | Contact number        | 0202 222 2222             |
      | Email                 | y@me.com                  |
      | Password              | SomeR3477yC0MPl3xP455w0rd |
      | Password confirmation | SomeR3477yC0MPl3xP455w0rd |
    And I create my account
    Then I should have an unverified account

  @wip
  Scenario: Event manager trying to sign in with an unverified account
    Given I am an unverified event manager
    When I sign in as an event manager
    Then I should not be signed in to my account

  @wip
  Scenario: Event manager sign in
    Given I am an unverified event manager
    When I sign in as an event manager
    Then I should be signed in to my account
