Feature: Manager can delete a dayoff
  In order to clear any mistakes
  As a manager on the account page
  I want to delete a dayoff

  Scenario: Deleting a dayoff from the account page
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And Someone else has approved time off
    When I am on the account page
    And I follow "delete" within the dayoff row
    Then the employee should receive an email

