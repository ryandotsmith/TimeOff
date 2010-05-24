Feature: Approving days off
  As a manager
  I want to approve days off
  So that people will know if a day off is approved by managment

  Background:
    Given an account exists with a subdomain of "wonderset"
    And I am signed in as the account owner

    Scenario: Displaying pending requests on the dashboard
      Given There are two pending days off
      When I am on the dashboard
      Then I should see "2"
      And I should see "requests need approval"

    Scenario: Displaying pending reqeusts for the current account on the dashboard
      Given There are two pending days off
      And There are two pending days off for another account
      When I am on the dashboard
      Then I should see "2"
      And I should see "requests need approval"

