Feature: Signing in
  As a person who belongs to an account
  I want to sign in to my account
  So that I can ask for time off and such

  Background:
    Given an account exists with a subdomain of "wonderset"
    And an account has been provisioned with email "ryan@aol.com" and password "password"

  Scenario: Signing in with an account that has been provisioned for me
    Given I am on the account sign in page
    When I fill in "email" with "ryan@aol.com"
    And I fill in "password" with "password"
    And I press "sign in"
    Then I should see "Welcome Back Ryan Smith"
    And I should see "wonderset"

  @wip
  Scenario: Signing in to an account with a user that does not belong to the account
    Given an account exists with a subdomain of "tft"
    And an account has been provisioned with email "ryan@test.com" and password "password"
    When I navigate to the "wonderset" account signing page
    And I fill in "email" with "ryan@test.com"
    And I fill in "password" with "password"
    And I press "sign in"
    Then I should see "Welcome Back Ryan Smith"
    And I should see "tft"
    And I should see "please bookmark tft for future sign in"
