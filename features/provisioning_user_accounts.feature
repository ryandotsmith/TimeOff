@wip
Feature: Provisioning useres for accounts
  In order to get employees in the system
  As an account owner
  I want to add users to my account

  Scenario: Adding users from the account page
    Given I am signed in as the account owner
    When I follow "add user"
    # And I fill in "email" with "this.ryansmith@gmail.com"
    # And I fill in "first name" with "Ryan"
    # And I fill in "last name" with "Smith"
    # And I press "add"
    Then I should see "email confirmation sent"

    
