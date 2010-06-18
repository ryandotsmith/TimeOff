Feature: Approving days off
  As a manager on the account page
  I want to approve days off
  So that people will know if a day off is approved by managment

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner

    Scenario: Displaying pending requests on the dashboard
      Given There are two pending days off
      When I am on the dashboard
      And I should see message "2 requests need approval"

    Scenario: Displaying pending reqeusts for the current account on the dashboard
      Given There are two pending days off
      And There are two pending days off for another account
      When I am on the dashboard
      And I should see message "2 requests need approval"

    Scenario: Approving a dayoff request
      Given There is a user with 4 vacation days remaining
      And The user is asking for 2 days off
      When I go to the dashboard
      Then I should see message "1 request needs approval"
      When I follow "respond"
      Then I should see "has 4.0 days remaining"
      When I press "approve"
      Then I should see "Request approved. An email has been sent to the employee." 
      And I should see message "0 requests need approval"

    @wip
    Scenario: Sending an email to the user who requested time off
      Given Someone else has pending time off 
      When I go to the account page
      And I follow "respond"
      And I press "approve"
      Then the employee should receive an email
