Feature: Requesting Days Off
  As an employee
  I want to request days off
  So that my requests are on record and can be approved by a manager

  Background:
    Given an account exists with a subdomain of "wonderset"
    And I am signed in as an employee of "wonderset"
    Given I am on the dashboard
    When I follow "request days off"

  @wip
  Scenario: Requesting a half day off
    Given I choose "dayoff_leave_length_half"
    And I select "December 25, 2008" as the "start day" date
    And I choose "dayoff_leave_type_vacation"
    And I fill in "message" with "need a half day off"
    When I press "submit"
    Then I should see "Request submitted! Supervisors have been notified."
    And I should see message "request pending approval 1"


  Scenario: Requesting a single day off
    Given I choose "dayoff_leave_length_whole"
    And I select "December 25, 2008" as the "start day" date
    And I choose "dayoff_leave_type_vacation"
    And I fill in "message" with "need some time off"
    When I press "submit"
    Then I should see "Request submitted! Supervisors have been notified."
    And I should see message "request pending approval 1"


