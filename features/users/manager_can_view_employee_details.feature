Feature: Manager can view employee details
  In order to view a list of the employees time off
  As a manager on the employee popup
  I want to click thru to see the details of the employee

  @wip
  Scenario: Cliking details on the employee popup
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And the following employee record
      |first_name|last_name|max_vacation|max_personal|
      |Ryan      |Smith    |10          |10          |
    Given the employee has a pending request for "2" days
    When I am on the dashboard
    And I follow "Ryan Smith" within "#queue"
    And I follow "employee history"
    Then I should see "Employee Profile"
