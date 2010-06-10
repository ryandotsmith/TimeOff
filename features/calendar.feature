Feature: Calendar
  As a user of time off
  I want to have calendars
  So that I can see who has time off

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as an employee of "wonderset"

  @javascript
  Scenario: Viewing a calendar on the day off request page
    Given There is a dayoff approved for today
    When I go to the new dayoff page
