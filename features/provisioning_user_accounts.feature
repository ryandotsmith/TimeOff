Feature: Provisioning useres for accounts
  In order to get employees in the system
  As an account owner
  I want to add users to my account

  Scenario: Adding users from the account page
    Given an account exists with a subdomain of "wonderset"
    And I am signed in as the account owner
    When I go to the account edit page
    And I follow "add user"
    And I fill in "Email" with "this.ryansmith@gmail.com"
    And I fill in "First Name" with "Ryan"
    And I fill in "Last Name" with "Smith"
    And I press "add"
    Then I should see "a new user was added to your account"
