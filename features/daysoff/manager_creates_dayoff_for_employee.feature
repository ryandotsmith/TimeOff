@wip
Feature: Manager creates dayoff for employee
  In order to help my employees keep accurate information
  As a manager on the employee show page
  I want to add time off for them

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner

  @javascript
  Scenario: Adding TimeOff
    Given I have a user in my account
    When I follow "employees"
    And I follow "add timeoff"
    And I choose "dayoff_leave_length_half"
    And I select "December 25, 2008" as the "dayoff_begin_time" date
    And I choose "dayoff_leave_type_vacation"
    And I fill in "Message" with "Jon needs a half day off"
    When I press "submit"
    Then the user should receive an email
