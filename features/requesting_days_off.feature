Feature: Requesting Days Off
  As an employee
  I want to request days off
  So that my requests are on record and can be approved by a manager

  Background:
    Given an account exists with a subdomain of "wonderset"
    And I am signed in as an employee of "wonderset"

  @wip
  Scenario: Requesting a single day off
    Given I am on the dashboard
    When I follow "request days off"
    And I select "December 25, 2008" as the "start day" date
    And I choose "dayoff_leave_type_whole"
    And I fill in "message" with "need some time off"
    When I press "submit"
    Then I should see "Request submitted! Supervisors have been notified."
