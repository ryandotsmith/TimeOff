Feature: Signing Out
  As a user
  I want to sign out
  So that I can do other things

  Background:
    Given an account exists with a subdomain of "wonderset"
    And an account has been provisioned with email "ryan@aol.com" and password "password"

  @wip
  Scenario: Signing out from the account page
    Given I am signed in
    And I am on account page
    When I follow "sign out"
    Then I should see "Goodbye"
     

