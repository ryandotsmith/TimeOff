Feature: Calendar
  As a user of time off
  I want to have calendars
  So that I can see who has time off

  @javascript
  Scenario: Viewing a calendar on the day off request page
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And Someone else has approved time off
    When I go to the account page
