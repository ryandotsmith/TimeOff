Feature: Manager can promote employee to manager
  In order to distribute work load among among the team
  As a manager on the user edit popup
  I want to promote the user to manager

  Background:
    Given an account exists with a company name of "wonderset"

    Scenario: Marking an employee as manager
      Given I am signed in as an employee of "wonderset"
      Then I should not see manager features
      When I follow "sign out"
      And I am signed in as the account owner
      And I am on the settings page
      When I follow "edit" within the user row
      And I check "Management Status"
      And I press "promote"
      And I follow "sign out"
      When I am signed in as an employee of "wonderset"
      Then I should see "Archive"

