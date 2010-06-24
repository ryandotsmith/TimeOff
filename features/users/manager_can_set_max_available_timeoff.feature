Feature: Managers can set max timeoff for employees
  In order to communicate the available timeoff to an employee
  As a manager on the edit user page
  I want to set the max time available

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner

  Scenario: Setting the max personal days
    Given an user exists
    And I am on the settings page
    When I follow "edit" within the user row
    And I fill in "Vacation" with "7"
    And I fill in "Personal" with "7"
    When I press "update timeoff"
    Then I should see "7" within the user row
