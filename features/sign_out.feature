Feature: Signing Out
  As a user
  I want to sign out
  So that I can do other things

  Scenario: Signing out from the account page
    Given an account exists with a subdomain of "wonderset"
    And an account has been provisioned with email "ryan@aol.com" and password "password"
    When I am signed in
    And I am on account page
    When I follow "sign out"
