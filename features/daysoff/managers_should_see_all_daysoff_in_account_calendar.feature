Feature: Manager should see all days off in account calendar
  In order to see what a month looks like w.r.t. employee time off
  As a manager on the account page
  I want to see all days off on the calendar

  @javascript
  Scenario: Viewing days off for all users in account
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And Someone else has approved time off
    When I am on the account page
    Then I should not see someone elses dayoff in the calendar
