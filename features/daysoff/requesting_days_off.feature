Feature: Requesting Days Off
  As an employee
  I want to request days off
  So that my requests are on record and can be approved by a manager

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as an employee of "wonderset"
    And I have a manager
    Given I am on the dashboard
    When I follow "request time off"

  Scenario: Requesting a half day off
    Given I choose "dayoff_leave_length_half"
    And I select "December 25, 2008" as the "dayoff_begin_time" date
    And I choose "dayoff_leave_type_vacation"
    And I fill in "Message" with "need a half day off"
    When I press "submit"
    Then I should see "Request submitted! Supervisors have been notified."
    And I should see message "request pending approval 1"

  @4162223
  Scenario: Requesting a single day off
    Given I choose "dayoff_leave_length_whole"
    And I select "December 25, 2008" as the "dayoff_begin_time" date
    And I choose "dayoff_leave_type_vacation"
    And I fill in "Message" with "need some time off"
    When I press "submit"
    Then I should see "Request submitted! Supervisors have been notified."
    And I should see message "request pending approval 1"
    And I my manager should have received an email

  @3856729
  Scenario: Viewing the new request in my history
    Given I have approved time off
    And I am on the account page
    When I follow "list" 
    Then I should have created a dayoff
    And I should see the dayoff in the table

  @javascript @3856722
  Scenario: Viewing the new request in my calendar
    Given I have approved time off
    And I am on the account page
    When I follow "calendar" 
    Then I should have my dayoff on the calendar

  @javascript @3856722
  Scenario: Not Viewing someone elses new request in my calendar
    Given Someone else has approved time off
    And I am on the account page
    When I follow "calendar" 
    Then I should not see someone elses dayoff in the calendar

