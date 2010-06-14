Feature: Manager should have a request queue
  In order to request user's time off
  As a manager on the account show page
  I want to see a list of time off requests for approval

  Scenario: Viewing the pending requests
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And Someone else has pending time off
    When I am on the account page
    Then I should see the request in the Pending Requests Queue

