Feature: Purchased ticket list
  As an events manager
  I should be able to print of a list of tickets sold

  @wip
  Scenario: Printing off a purchase list
    Given I have created a verified event
    And tickets have been sold for this event
    When I am on the purhcased tickets list
    Then I should be able to download a couple of the list
