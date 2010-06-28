Feature: Mnager can see employee snapshot in a popup
  In order to quickly determine an employees timeoff status
  As a manager on any page with an employees name
  I want to be able to click there name and see their timeoff history

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And the following employee record
      |first_name|last_name|max_vacation|max_personal|
      |Ryan      |Smith    |10          |10          |
    Given the employee has a pending request for "2" days
    When I am on the dashboard

  Scenario: Viewing the popup from the request queue
    When I follow "Ryan Smith" within "#queue"
    Then I should see "Ryan Smith"
    And I should see "10.0 days" within "tr.vacation td.remaining"
    And I should see "10.0 days" within "tr.personal td.remaining"

  Scenario: Viewing the popup from the history calendar
    # I can not test this becaues the calendar does not use a href to open links
