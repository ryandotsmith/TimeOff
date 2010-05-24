Feature: Approving days off
  As a manager
  I want to approve days off
  So that people will know if a day off is approved by managment

  Scenario: Displaying pending requests on the dashboard
    Given an account exists with a subdomain of "wonderset"
    And There are two pending days off
    And I am signed in as the account owner
    And I am on the dashboard
    Then I should see "2"
    Then I should see "requests need approval"
