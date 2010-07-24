Feature: Locking an account with expired trial
  In order to gain access to my account
  As the customer on the sign in page
  I want to update my subscription

  @wip
  Scenario: Sgin In
    Given an expired account exists with a company name of "wonderset"
    And I am signed in as the account owner
    Then I should see "Card Number"
