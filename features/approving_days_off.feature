Feature: Approving days off
  As a manager
  I want to approve days off
  So that people will know if a day off is approved by managment

  Background:
    Given an account exists with a subdomain of "wonderset"
    And I am signed in as the account owner

  @wip
  Scenario: Displaying pending requests on the dashboard
    Given I am on the dashboard
    And There are two pending days off
    Then I should see "2 requests need approval"
