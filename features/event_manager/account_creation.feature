Feature: Creating a new account
  As a event manager
  I want to be able to sign up and store my event details

  @wip
  Scenario: Signing up
    Given that I am on the sign up page
    When I fill in the following event information:
      | field      | value    |
      | first name | joe      |
      | last name  | smith    |
      | email      | y@me.com |
    And I create my account
    Then I should receive an verification email
