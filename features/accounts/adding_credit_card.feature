Feature: Adding a credit card
  In order to continue my service
  As a manager on the billing page
  I want to add my credit card

  Background:
    Given an expired account exists with a company name of "wonderset"
    And I am signed in as the account owner

  @wip @chargify
  Scenario: Valid Card
    When I fill in "Name on Card" with "Ryan Smith"
    And I fill in "Card Number" with "1"

    And I select "2" from "Expiration Month"
    And I select "2012" from "Expiration Year"

    And I fill in "Security Code" with "123"
    When I press "submit"
    Then I should see "Account Subscription Successfully Updated" within ".message"

