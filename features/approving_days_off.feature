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
      And I should see message "requests need approval 2"

    Scenario: Displaying pending reqeusts for the current account on the dashboard
      Given There are two pending days off
      And There are two pending days off for another account
      When I am on the dashboard
      And I should see message "requests need approval 2"

    Scenario: Approving a dayoff request
      Given There is a user with 4 vacation days remaining
      And The user is asking for 2 days off
      When I go to the dashboard
      Then I should see message "request needs approval 1"
      When I follow "approve"
      Then I should see "has 4.0 days remaining"
      When I press "approve"
      Then I should see "request updated" 
      And I should see message "requests need approval 0"
